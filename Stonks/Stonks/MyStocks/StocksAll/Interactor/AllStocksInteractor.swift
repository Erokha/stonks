import Foundation
import Alamofire

final class AllStocksInteractor {
    weak var output: AllStoksInteractorOutput?
    private var updateTimer: Timer?

    init() {
        setupTimer()
    }

    private func setupTimer() {
        self.updateTimer = Timer.scheduledTimer(timeInterval: Constants.requestPeriod,
                                                      target: self,
                                                      selector: #selector(loadStoks),
                                                      userInfo: nil,
                                                      repeats: true)
    }

    private func handleError(with error: Error) {
        switch error.localizedDescription {
        case NetworkErrors.sessionTaskFailed.type:
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
    @objc func loadStoks() {
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

enum NetworkErrors {
    case sessionTaskFailed
}

extension NetworkErrors {
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

extension AllStocksInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
