import Foundation
import Alamofire

final class MyStocksInteractor {
    weak var output: MyStoksInteractorOutput?

    private func handleError(with error: Error) {
        print(error)
    }

    private func handleStock(with stocksRaw: [StockRaw]) {
        let stocks: [StockData] = stocksRaw.map({ StockData(with: $0) })
        output?.didRecive(stoks: stocks)
    }

}

extension MyStocksInteractor: MyStoksInteractorInput {
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

final class MyStocksMockInteractor {
    weak var output: MyStoksInteractorOutput?

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

extension MyStocksMockInteractor: MyStoksInteractorInput {
    func loadStoks() {
        handleStock(with: [StockRaw(stockName: "asd", stockSymbol: "asd", stockPrice: 12, imageUrl: "asd")])
    }

}
