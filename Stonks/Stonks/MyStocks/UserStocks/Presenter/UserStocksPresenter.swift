import UIKit
import Alamofire

class UserStocksPresenter {
    var model: [StockData]? {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    weak var view: UserStocksViewInput?
    var router: StocksSharedRouterInput?
    private let interactor: UserStoksInteractorInput

    init(interactor: UserStoksInteractorInput) {
        self.interactor = interactor
    }

}

extension UserStocksPresenter: UserStocksViewOutput {
    func didTapOnStock(symbol: String) {
        router?.showStockDetail(symbol: symbol)
    }

    func didLoadView() {
        view?.startActivity()
        interactor.loadStocksFromCoreData()
    }

    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

    func stock(at indexPath: IndexPath) -> StockData? {
        return self.model?[indexPath.row] ?? nil
    }

    func refreshData() {
        interactor.loadStoks(symbols: ["AAPL", "MSFT"]) // HARDCODE
    }
}

extension UserStocksPresenter: UserStoksInteractorOutput {
    func didReciveUpdate(userStockUpdate: [String: Float]) {
        guard var data = self.model else { return }
        for i in 0...data.count - 1 {
            data[i].stockPrice = userStockUpdate[data[i].stockSymbol] ?? 0
        }
        self.model = data
        view?.endActivity()
    }

    func didReciveCoreData(stocks: [StockData]) {
        self.model = stocks
        var symbolsArray: [String] = []
        guard let data = model else { return }
        for stock in data {
            symbolsArray.append(stock.stockSymbol)
        }
        interactor.loadStoks(symbols: symbolsArray)
    }

    func didReciveError(with error: Error) {
        router?.showError(with: error)
        view?.endActivity()
    }

}
