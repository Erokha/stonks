import Foundation
import Alamofire

final class MePortfolioInteractor {
    weak var output: MePortfolioInteractorOutput?

    private func handleError(with error: Error) {
        // DO ERRORS
    }

    private func handleStocks(stocks: [Stock]) {
        var stocksData: [MePortfolioStockData] = []
        for stock in stocks {
            // request to network
            let stockData = MePortfolioStockData(with: stock, currentPrice: Float(Int.random(in: 1...50)))
            stocksData.append(stockData)
        }
        output?.didLoaded(stocks: stocksData)
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
