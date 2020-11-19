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
        guard let user = UserDataService.shared.getUser() else { return }
        guard let allStocks = user.stocks?.allObjects as? [Stock] else { return }
        let stocks: [StockData] = allStocks.map({ StockData(with: $0) })
        output?.didReciveCoreData(stocks: stocks)
    }

    func loadStoks(symbols: [String]) {
        var tmp = Set(symbols)
        tmp.remove("Apple")
        let stockRequest = tmp.joined(separator: ",")
        print(stockRequest)
        let url = "http://stonks.kkapp.ru:8000/stock/\(stockRequest)"
        let request = AF.request(url)
        request.responseDecodable(of: [StockRaw].self) { [weak self] response in
            switch response.result {
            case .success(let stocksRaw):
                self?.handleStock(with: stocksRaw)
            case .failure(let error):
                self?.handleError(with: error)
            }
        }
    }
}
