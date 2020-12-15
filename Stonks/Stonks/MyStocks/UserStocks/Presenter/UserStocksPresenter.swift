import UIKit
import Alamofire

class UserStocksPresenter {
    var model: [StockData]? {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
                self.delegate?.getTotalStocksCount(with: self.calculateStocksTotal)
            }
        }
    }
    weak var view: UserStocksViewInput?
    var router: StocksSharedRouterInput?
    weak var delegate: UserStocksDelegate?
    private let interactor: UserStoksInteractorInput
    private var updateTimer: Timer?

    init(interactor: UserStoksInteractorInput) {
        self.interactor = interactor
    }

    private func setupTimer() {
        self.updateTimer = Timer.scheduledTimer(timeInterval: Constants.requestPeriod,
                                                      target: self,
                                                      selector: #selector(self.requestUpdate),
                                                      userInfo: nil,
                                                      repeats: true)
    }

    private var calculateStocksTotal: Int {
        var tmp: Float = 0
        guard let data = self.model else { return 0 }
        for stock in data {
            tmp += Float(stock.stockCount) * stock.stockPrice
        }
        return Int(tmp)
    }

}

extension UserStocksPresenter: UserStocksViewOutput {
    func didTapOnStock(symbol: String) {
        router?.showStockDetail(symbol: symbol)
    }

    func didLoadView() {
        view?.startActivity()
        interactor.loadStocksFromCoreData()
        setupTimer()
    }

    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

    func stock(at indexPath: IndexPath) -> StockData? {
        return self.model?[indexPath.row] ?? nil
    }

    func refreshData() {
        view?.startActivity()
        interactor.loadStocksFromCoreData()
    }

    func routerHardResetUpdate() {
        router?.hardResetUpdateFlag()
    }
}

extension UserStocksPresenter: UserStoksInteractorOutput {
    func didReciveUpdate(userStockUpdate: [String: (Float, String)]) {
        guard var data = self.model else { return }
        for i in 0..<data.count {
            data[i].stockPrice = userStockUpdate[data[i].stockSymbol]?.0 ?? 0
            data[i].imageUrl = userStockUpdate[data[i].stockSymbol]?.1 ?? "not found"
        }
        self.model = data
        view?.endActivity()
        delegate?.getTotalStocksCount(with: 100)
    }

    func didReciveCoreData(stocks: [StockData]) {
        self.model = stocks
        var symbolsArray: [String] = []
        guard let data = model else { return }
        for stock in data {
            symbolsArray.append(stock.stockSymbol)
        }
        interactor.loadStoks(symbols: symbolsArray)
        view?.endActivity()
    }

    @objc func requestUpdate() {
        var symbolsArray: [String] = []
        guard let data = model else { return }
        for stock in data {
            symbolsArray.append(stock.stockSymbol)
        }
        interactor.loadStoks(symbols: symbolsArray)
        view?.endActivity()
    }

    func didReciveError(with error: Error) {
        view?.endActivity()
        router?.showError(with: error)
    }

}

extension UserStocksPresenter {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
