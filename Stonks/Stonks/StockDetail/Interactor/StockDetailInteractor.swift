import Foundation
import CoreData

final class StockDetailInteractor: NSObject {
    weak var output: StockDetailInteractorOutput?

    private var frcUser: NSFetchedResultsController<User>?

    private var stock: StockInteractorData?

    private var updateQuotesTimer: Timer?

    init(symbol: String) {
        super.init()

        configureFrcUser()
        frcUser?.delegate = self

        if StockDataService.shared.stockIsNew(symbol: symbol) {
            NetworkService.shared.fetchStockName(for: symbol) { [weak self] result in
                if let error = result.error {
                    print(error)
                    return
                }

                guard let stockName = result.data else {
                    return
                }

                self?.stock = StockInteractorData(name: stockName, symbol: symbol)
                self?.fetchStockData()
            }
        } else {
            guard let fetchedStock = StockDataService.shared.getStock(symbol: symbol) else {
                return
            }

            self.stock = StockInteractorData(stock: fetchedStock)
        }

        setupUpdateTimer()
    }

    private func setupUpdateTimer() {
        self.updateQuotesTimer = Timer.scheduledTimer(timeInterval: Constants.requestPeriod,
                                                      target: self,
                                                      selector: #selector(fetchFreshCost),
                                                      userInfo: nil,
                                                      repeats: true)
    }

    private func configureFrcUser() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]

        frcUser = NSFetchedResultsController(fetchRequest: fetchRequest,
                                         managedObjectContext: DataService.shared.getPersistentContainer().viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)
        do {
            try frcUser?.performFetch()
        } catch {
            fatalError("StockDetailInteractor: User request not fetched!")
        }
    }

    private func sendCardData(data: CardData) {
        output?.cardDataDidReceived(model: StockPresenterData(cardData: data))
    }

    private func prepareCardModel(user: User) -> CardData {
        return CardData(leftNumber: Int(user.totalSpent.floatValue),
                        rightNumber: Int(user.balance.floatValue))
    }

    private func refreshCoreDataStock(with stock: StockInteractorData) {
        guard let fetchedStock = StockDataService.shared.getStock(symbol: stock.symbol) else {
            return
        }

        fetchedStock.name = stock.name
        fetchedStock.symbol = stock.symbol
        fetchedStock.amount = stock.amount
        fetchedStock.priceHistory = stock.priceHistory
        fetchedStock.totalCost = stock.totalCost

        StockDataService.shared.updateStock(symbol: stock.symbol, stock: fetchedStock)
    }

    @objc
    private func fetchFreshCost(timer: Timer) {
        guard var stock = stock,
              !stock.priceHistory.isEmpty else {
            return
        }

        NetworkService.shared.fetchStocksFreshPrice(for: [stock.symbol]) { [weak self] result in
            if let error = result.error {
                print(error)
                return
            }

            guard let freshPrice = result.data?.first else {
                return
            }

            stock.priceHistory.removeFirst()
            stock.priceHistory.append(NSDecimalNumber(value: freshPrice.stockPrice))

            if !StockDataService.shared.stockIsNew(symbol: stock.symbol) {
                self?.refreshCoreDataStock(with: stock)
            }

            self?.stock = stock
            self?.output?.freshCostDidReceived(model: StockPresenterData(model: stock))
        }
    }
}

extension StockDetailInteractor: StockDetailInteractorInput {
    func fetchCardData() {
        guard let user = UserDataService.shared.getUser() else {
            return
        }

        sendCardData(data: prepareCardModel(user: user))
    }

    func increaseAmount(by value: Int) {
        guard value > 0 else {
            output?.showAlert(with: "Oops!", message: "Amount should be > 0")
            return
        }

        guard var stock = self.stock,
              let user = UserDataService.shared.getUser(),
              let freshPrice = stock.priceHistory.last else {
            return
        }

        let transactionCost = (freshPrice as Decimal) * Decimal(value)

        guard user.balance as Decimal >= transactionCost else {
            output?.showAlert(with: "Oops!", message: "You don't have enough money")
            return
        }

        user.balance = user.balance.adding(NSDecimalNumber(decimal: -transactionCost))
        stock.totalCost = stock.totalCost.adding(NSDecimalNumber(decimal: transactionCost))
        stock.amount += value

        UserDataService.shared.editUser(user: user)

        if !StockDataService.shared.stockIsNew(symbol: stock.symbol) {
            refreshCoreDataStock(with: stock)
        } else if stock.amount > 0 {
            StockDataService.shared.createStock(name: stock.name,
                                                symbol: stock.symbol,
                                                totalCost: stock.totalCost,
                                                amount: stock.amount,
                                                priceHistory: stock.priceHistory)
        }

        self.stock = stock
        StockHistoryDataService.shared.createHistoryStock(name: stock.name, symbol: stock.symbol, price: transactionCost, type: .bought)
        output?.stockAmountUpdated(model: StockPresenterData(model: stock))
    }

    func descreaseAmount(by value: Int) {
        guard value > 0 else {
            output?.showAlert(with: "Oops!", message: "Amount should be > 0")
            return
        }

        guard var stock = self.stock,
              let user = UserDataService.shared.getUser(),
              let freshPrice = stock.priceHistory.last else {
            return
        }

        guard stock.amount >= value else {
            output?.showAlert(with: "Oops!", message: "You don't have enough stocks of this type")
            return
        }

        let transactionCost = (freshPrice as Decimal) * Decimal(value)

        user.balance = user.balance.adding(NSDecimalNumber(decimal: transactionCost))
        stock.amount -= value

        if stock.amount == 0 {
            stock.totalCost = 0
        } else {
            stock.totalCost = stock.totalCost.adding(NSDecimalNumber(decimal: -transactionCost))
        }

        UserDataService.shared.editUser(user: user)

        if stock.amount == 0 && !StockDataService.shared.stockIsNew(symbol: stock.symbol) {
            StockDataService.shared.deleteStock(symbol: stock.symbol)
        }

        if !StockDataService.shared.stockIsNew(symbol: stock.symbol) {
            refreshCoreDataStock(with: stock)
        }

        self.stock = stock
        StockHistoryDataService.shared.createHistoryStock(name: stock.name, symbol: stock.symbol, price: transactionCost, type: .sold)
        output?.stockAmountUpdated(model: StockPresenterData(model: stock))
    }

    func fetchStockData() {
        guard var stock = self.stock else {
            return
        }

        NetworkService.shared.fetchStockHistory(for: stock.symbol) { [weak self] result in
            if let error = result.error {
                print(error)
                return
            }

            guard let data = result.data else {
                return
            }

            stock.priceHistory = data.map { NSDecimalNumber(value: $0) }.reversed()

            if !StockDataService.shared.stockIsNew(symbol: stock.symbol) {
                self?.refreshCoreDataStock(with: stock)
            }

            self?.stock = stock
            self?.output?.stockDataDidReceived(model: StockPresenterData(model: stock))
        }
    }

    func stopFetching() {
        updateQuotesTimer?.invalidate()
    }
}

extension StockDetailInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let user = controller.fetchedObjects?.first as? User {
            sendCardData(data: prepareCardModel(user: user))
        }
    }
}

extension StockDetailInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
