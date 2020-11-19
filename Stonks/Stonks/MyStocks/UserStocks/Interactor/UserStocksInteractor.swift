import Foundation
import Alamofire

final class UserStocksInteractor {
    weak var output: UserStoksInteractorOutput?

    private func handleError(with error: Error) {
        switch error.localizedDescription {
        case networkErrors.sessionTaskFailed.type:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }

    private func handleStock(with stocksRaw: [StockRaw]) {
        var stocksDict: [String: (Float, String)] = [:]
        for element in stocksRaw {
            stocksDict[element.stockSymbol] = (element.stockPrice, element.imageUrl)
        }
        output?.didReciveUpdate(userStockUpdate: stocksDict)
    }

}

extension UserStocksInteractor: UserStoksInteractorInput {
    func loadStocksFromCoreData() {
        guard let coreStocks = StockDataService.shared.getAllStocks() else { return }
        let stocks: [StockData] = coreStocks.map({ StockData(with: $0) })
        output?.didReciveCoreData(stocks: stocks)
    }

    func loadStoks(symbols: [String]) {
        NetworkService.shared.fetchStocksFreshPrice(for: symbols, completion: { [weak self] result in
            if let error = result.error {
                self?.handleError(with: error)
                return
            }

            guard let stocks = result.data else {
                return
            }
            self?.handleStock(with: stocks)
        })
    }
}
