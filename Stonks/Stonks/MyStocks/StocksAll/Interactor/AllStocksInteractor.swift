import Foundation
import Alamofire

final class AllStocksInteractor {
    weak var output: AllStoksInteractorOutput?

    private func handleError(with error: AFError?) {
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
        NetworkService.shared.fetchAllStocks { [weak self] result in
            if let error = result.error {
                self?.handleError(with: error.asAFError)
                return
            }

            guard let stocks = result.data else {
                return
            }

            self?.handleStock(with: stocks)
        }
    }

}
