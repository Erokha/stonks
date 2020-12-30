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
        DispatchQueue.global(qos: .background).async {
            let timer = Timer.scheduledTimer(timeInterval: Constants.requestPeriod,
                                                          target: self,
                                                          selector: #selector(self.fetchFreshCost),
                                                          userInfo: nil,
                                                          repeats: true)
            self.updateQuotesTimer = timer

            let runLoop = RunLoop.current

            runLoop.add(timer, forMode: .default)
            runLoop.run()
        }
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

    private func sendCardBalance(newBalance: NSDecimalNumber) {
        output?.balanceUpdateDidReceived(balance: Int(newBalance.floatValue))
    }

    private func sendCardAmountPrice(newPrice: NSDecimalNumber) {
        output?.amountPriceUpdateDidReceived(amountPrice: Int(newPrice.floatValue))
    }

    private func prepareCardModel(user: User) -> CardData {
        guard let stock = stock else {
            return CardData(leftNumber: .zero, rightNumber: .zero)
        }

        let yourAmountPrice = (stock.priceHistory.last ?? .zero).multiplying(by: NSDecimalNumber(value: stock.amount))

        return CardData(leftNumber: Int(yourAmountPrice.floatValue),
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

            DispatchQueue.main.async {
                self?.stock?.priceHistory = stock.priceHistory
                self?.output?.freshCostDidReceived(model: StockPresenterData(model: self?.stock ?? stock))
            }
        }
    }
}

extension StockDetailInteractor: StockDetailInteractorInput {
    func fetchAmountPrice() {
        guard let stock = stock else {
            return
        }

        let price = (stock.priceHistory.last ?? .zero).multiplying(by: NSDecimalNumber(value: stock.amount))

        sendCardAmountPrice(newPrice: price)
    }

    func fetchBalance() {
        guard let user = UserDataService.shared.getUser() else {
            return
        }

        sendCardBalance(newBalance: user.balance)
    }

    func increaseAmount(by value: Int) {
        guard value > .zero else {
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
        } else if stock.amount > .zero {
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
        guard value > .zero else {
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

        if stock.amount == .zero {
            stock.totalCost = .zero
        } else {
            stock.totalCost = stock.totalCost.adding(NSDecimalNumber(decimal: -transactionCost))
        }

        UserDataService.shared.editUser(user: user)

        if stock.amount == .zero && !StockDataService.shared.stockIsNew(symbol: stock.symbol) {
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
            sendCardBalance(newBalance: user.balance)
        }
    }
}

extension StockDetailInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 300
    }
}
