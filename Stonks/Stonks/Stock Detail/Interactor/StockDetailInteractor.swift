import Foundation

class StockDetailInteractor {
    weak var output: StockDetailInteractorOutput?

    private var model: StockDetailInteractorData

    private var updateQuotesTimer: Timer?

    init(model: StockDetailInteractorData) {
        self.model = model
        self.model.stock = StockDataService.shared.getStock(with: model.name)

        setupUpdateTimer()
    }

    private func setupUpdateTimer() {
        self.updateQuotesTimer = Timer.scheduledTimer(timeInterval: Constants.requestPeriod,
                                                      target: self,
                                                      selector: #selector(fetchFreshCost),
                                                      userInfo: nil,
                                                      repeats: true)
    }

    @objc
    private func fetchFreshCost() {
        let freshPrice = Double.random(in: 0...50)

        guard let stock = model.stock else {
            return
        }

        stock.freshPrice = NSDecimalNumber(value: freshPrice)
        StockDataService.shared.updateStock(name: stock.name, stock: stock)

        output?.freshCostDidReceived(cost: freshPrice)
    }

    deinit {
        updateQuotesTimer?.invalidate()
    }
}

extension StockDetailInteractor: StockDetailInteractorInput {
    func increaseAmount(for name: String, value: Int) {
        guard let stock = StockDataService.shared.getStock(with: name),
              let user = UserDataService.shared.getUser() else {
            return
        }

        let transactionCost = (stock.freshPrice as Decimal) * Decimal(value)

        guard user.balance as Decimal >= transactionCost else {
            output?.showAlert(with: "Oops!", message: "You don't have enough money")
            return
        }

        user.balance = user.balance.adding(NSDecimalNumber(decimal: -transactionCost))
        stock.amount += value

        UserDataService.shared.editUser(user: user)
        StockDataService.shared.updateStock(name: stock.name, stock: stock)
    }

    func descreaseAmount(for name: String, value: Int) {
        guard let stock = StockDataService.shared.getStock(with: name),
              let user = UserDataService.shared.getUser() else {
            return
        }

        guard stock.amount >= value else {
            output?.showAlert(with: "Oops!", message: "You don't have enough stocks of this type")
            return
        }

        let transactionCost = (stock.freshPrice as Decimal) * Decimal(value)

        user.balance = user.balance.adding(NSDecimalNumber(decimal: transactionCost))
        stock.amount -= value

        UserDataService.shared.editUser(user: user)
        StockDataService.shared.updateStock(name: stock.name, stock: stock)
    }

    func fetchStockQuotes(for name: String) {
        // тут запрос в сеть котировок за последние 20 минут

        var dataset: [(Double, Double)] = []

        for i in 0..<30 {
            let value = Double.random(in: 0.0 ... 50.0)
            dataset.append((Double(i), value))
        }

        guard let stock = model.stock else {
            return
        }

        stock.freshPrice = NSDecimalNumber(value: dataset[dataset.count - 1].1)
        StockDataService.shared.updateStock(name: stock.name, stock: stock)

        output?.stockQuotesDidReceived(quotes: dataset)
    }
}

extension StockDetailInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
