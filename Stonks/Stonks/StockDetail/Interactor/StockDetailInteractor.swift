import Foundation
import CoreData

class StockDetailInteractor: NSObject {
    weak var output: StockDetailInteractorOutput?

    private var frc: NSFetchedResultsController<User>?

    private var stock: Stock?

    private var updateQuotesTimer: Timer?

    init(symbol: String) {
        super.init()

        configureFrc()
        frc?.delegate = self

        if StockDataService.shared.stockIsNew(symbol: symbol) {
            // тут запрос в сеть
            guard let url = URL(string: "sdsd") else {
                return
            }

            StockDataService.shared.createStock(name: "SpaceX", symbol: symbol, imageURL: url)
            self.stock = StockDataService.shared.getStock(symbol: symbol)
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

    private func configureFrc() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                         managedObjectContext: DataService.shared.getPersistentContainer().viewContext,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)
        do {
            try frc?.performFetch()
        } catch {
            fatalError("StockDetailInteractor: Request not fetched!")
        }
    }

    private func sendCardData(data: CardData) {
        output?.cardDataDidReceived(model: StockDetailPresenterData(cardData: data))
    }

    private func prepareModel(user: User) -> CardData {
        return CardData(leftNumber: Int(user.totalSpent.floatValue),
                        rightNumber: Int(user.balance.floatValue))
    }

    @objc
    private func fetchFreshCost(timer: Timer) {
        guard let stock = self.stock,
              !stock.priceHistory.isEmpty else {
            return
        }

        let freshPrice = Double.random(in: 0...50)

        stock.priceHistory.removeFirst()
        stock.priceHistory.append(NSDecimalNumber(value: freshPrice))

        StockDataService.shared.updateStock(symbol: stock.symbol, stock: stock)
        output?.freshCostDidReceived(model: StockDetailPresenterData(model: stock))
    }

    deinit {
        guard let user = UserDataService.shared.getUser(),
              let stocks = user.stocks?.allObjects as? [Stock] else {
            return
        }

        for stock in stocks where stock.amount == 0 {
            print(stock.symbol)
            StockDataService.shared.deleteStock(symbol: stock.symbol)
        }
    }
}

extension StockDetailInteractor: StockDetailInteractorInput {
    func fetchCardData() {
        guard let user = UserDataService.shared.getUser() else {
            return
        }

        sendCardData(data: prepareModel(user: user))
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

    func fetchStockQuotes() {
        guard let stock = self.stock else {
            return
        }

        var priceHistory: [NSDecimalNumber] = []

        for _ in 0..<30 {
            let value = Double.random(in: 0.0 ... 50.0)
            priceHistory.append(NSDecimalNumber(value: value))
        }

        stock.priceHistory = priceHistory
        StockDataService.shared.updateStock(symbol: stock.symbol, stock: stock)

        output?.stockHistoryDidReceived(model: StockDetailPresenterData(model: stock))
    }

    func stopFetching() {
        updateQuotesTimer?.invalidate()
    }
}

extension StockDetailInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchResult = controller.fetchedObjects?.first as? User else {
            return
        }

        sendCardData(data: prepareModel(user: fetchResult))
    }
}

extension StockDetailInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
