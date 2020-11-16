import Foundation

final class MeHistoryPresenter {
    weak var view: MeHistoryInput?
    private var interactor: MeHistoryInteractorInput
    var router: MeHistoryRouterInput?

    private var stocks: [StockHistoryData] = [] {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    init(interactor: MeHistoryInteractorInput) {
        self.interactor = interactor
    }

}

extension MeHistoryPresenter: MeHistoryOutput {
    func didSortedStocksLoaded(stocks: [StockHistoryData]) {
        self.stocks = stocks
    }

    func didFilterButtonTapped() {
        router?.showFilter()
    }

    func didLoadView() {
        interactor.loadStocks()
    }

    func getNumberOfStocks() -> Int {
        return stocks.count
    }

    func stock(at indexPath: IndexPath) -> StockHistoryData? {
        return stocks[indexPath.row]
    }
}

extension MeHistoryPresenter: MeHistoryInteractorOutput {
    func didReceive(stocks: [StockHistoryData]) {
        self.stocks = stocks
    }
}
