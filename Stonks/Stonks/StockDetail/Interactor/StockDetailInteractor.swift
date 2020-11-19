import Foundation
import CoreData

final class StockDetailInteractor: NSObject {
    weak var output: StockDetailInteractorOutput?

    private var frcUser: NSFetchedResultsController<User>?

    private var frcStock: NSFetchedResultsController<Stock>?

    private var stock: Stock?

    private var updateQuotesTimer: Timer?

    init(symbol: String) {
        super.init()

        configureFrcUser()
        configureFrcStock()
        frcUser?.delegate = self
        frcStock?.delegate = self

        if StockDataService.shared.stockIsNew(symbol: symbol) {
            NetworkService.shared.fetchStockName(for: symbol) { [weak self] result in
                if let error = result.error {
                    print(error)
                    return
                }

                guard let stockName = result.data else {
                    return
                }

                StockDataService.shared.createStock(name: stockName, symbol: symbol)
                self?.stock = StockDataService.shared.getStock(symbol: symbol)
                self?.fetchStockData()
            }
        } else {
            self.stock = StockDataService.shared.getStock(symbol: symbol)
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

    private func configureFrcStock() {
        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)

        fetchRequest.sortDescriptors = [sortDescriptor]

        frcStock = NSFetchedResultsController(fetchRequest: fetchRequest,
                                              managedObjectContext: DataService.shared.getPersistentContainer().viewContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)

        do {
            try frcStock?.performFetch()
        } catch {
            fatalError("StockDetailInteractor: Stock request not fetched")
        }
    }

    private func sendCardData(data: CardData) {
        output?.cardDataDidReceived(model: StockDetailPresenterData(cardData: data))
    }

    private func prepareCardModel(user: User) -> CardData {
        return CardData(leftNumber: Int(user.totalSpent.floatValue),
                        rightNumber: Int(user.balance.floatValue))
    }

    @objc
    private func fetchFreshCost(timer: Timer) {
        guard let stock = self.stock,
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
            stock.priceHistory.append(NSDecimalNumber(value: freshPrice))

            StockDataService.shared.updateStock(symbol: stock.symbol, stock: stock)
            self?.output?.freshCostDidReceived(model: StockDetailPresenterData(model: stock))
        }
    }

    deinit {
        guard let user = UserDataService.shared.getUser(),
              let stocks = user.stocks?.allObjects as? [Stock] else {
            return
        }

        for stock in stocks where stock.amount == 0 {
            StockDataService.shared.deleteStock(symbol: stock.symbol)
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
        guard let stock = self.stock,
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
        StockDataService.shared.updateStock(symbol: stock.symbol, stock: stock)
    }

    func descreaseAmount(by value: Int) {
        guard let stock = self.stock,
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
        StockDataService.shared.updateStock(symbol: stock.symbol, stock: stock)
    }

    func fetchStockData() {
        guard let stock = self.stock else {
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
            StockDataService.shared.updateStock(symbol: stock.symbol, stock: stock)

            self?.output?.stockDataDidReceived(model: StockDetailPresenterData(model: stock))
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
        } else if let stocks = controller.fetchedObjects as? [Stock] {
            guard let stock = stock else {
                return
            }

            for updatedStock in stocks where updatedStock.symbol == stock.symbol {
                output?.stockDataDidReceived(model: StockDetailPresenterData(model: stock))
                break
            }
        }
    }
}

extension StockDetailInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
