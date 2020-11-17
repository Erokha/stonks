import Foundation
import Alamofire

final class AllStocksInteractor {
    weak var output: AllStoksInteractorOutput?

    private func handleError(with error: Error) {
        switch error.localizedDescription {
        case networkErrors.sessionTaskFailed.type:
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
                self?.handleError(with: error)
                return
            }

            guard let stocks = result.data else {
                return
            }

            self?.handleStock(with: stocks)
        }
    }

}

enum networkErrors {
    case sessionTaskFailed
}

extension networkErrors {
    var type: String {
        switch self {
        case .sessionTaskFailed:
            return errorStrings.sessionTaskFailed
        }
    }
}

private struct errorStrings {
    static let sessionTaskFailed = "URLSessionTask failed with error: Could not connect to the server."
}
