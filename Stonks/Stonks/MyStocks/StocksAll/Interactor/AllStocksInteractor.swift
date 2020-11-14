import Foundation
import Alamofire

final class AllStocksInteractor {
    weak var output: AllStoksInteractorOutput?

    private func handleError(with error: AFError) {
        switch error {
        case .sessionTaskFailed:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }

    private func handleStock(with stocksRaw: [StockRaw]) {
        let stocks: [StockData] = stocksRaw.map({ StockData(with: $0) })
        output?.didRecive(stoks: stocks)
    }

}

extension AllStocksInteractor: AllStoksInteractorInput {
    func loadStoks() {
        let url = "http://stonks.kkapp.ru:8000/allStocks"
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
