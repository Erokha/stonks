import Foundation

class StockDetailInteractor {
    weak var output: StockDetailInteractorOutput?
}

extension StockDetailInteractor: StockDetailInteractorInput {
    func increaseAmount(for name: String, value: Int) {
        guard let stock = StockDataService.shared.getStock(with: name) else {
            return
        }

        //let transactionCost = stock.price * NSDecimalNumber(integerLiteral: value)

        guard let user = UserDataService.shared.getUser() else {
            return
        }

    }

    func descreaseAmount(for name: String, value: Int) {

    }

    func fetchStockQuotes(for name: String) {
        // тут запрос в сеть котировок за последние 20 минут

        var dataset: [(Double, Double)] = []

        for i in 0..<20 {
            let value = Double.random(in: 0.0 ... 50.0)
            dataset.append((Double(i), value))
        }

        output?.stockQuotesDidReceived(quotes: dataset)
    }

    func fetchFreshCost(for name: String) {
        output?.freshCostDidReceived(cost: Double.random(in: 0...50))
    }
}
