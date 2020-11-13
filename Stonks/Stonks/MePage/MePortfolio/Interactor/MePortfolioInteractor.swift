import Foundation

class MePortfolioInteractor {
    weak var output: MePortfolioInteractorOutput?

    private func handleStocks(stocks: [Stock]) {
        print(stocks.count)
        for stock in stocks {
            print(stock.symbol)
        }
    }
}

extension MePortfolioInteractor: MePortfolioInteractorInput {
    func loadStocks() {
        if let stocks = StockDataService.shared.getAllStocks() {
            handleStocks(stocks: stocks)
        } else {
            handleStocks(stocks: [])
        }
    }
}
