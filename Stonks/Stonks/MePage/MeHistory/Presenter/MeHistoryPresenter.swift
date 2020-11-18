import Foundation

final class MeHistoryPresenter {
    weak var view: MeHistoryInput?
    private var interactor: MeHistoryInteractorInput
    var router: MeHistoryRouterInput?

    private var stocks: [StockHistoryData] = [] {
        didSet {
            self.view?.reloadTable()
        }
    }
    init(interactor: MeHistoryInteractorInput) {
        self.interactor = interactor
    }

}

extension MeHistoryPresenter: MeHistoryOutput {
    func didUserStartToSearch(search: String) {
        var filtered: [StockHistoryData] = []

        if !search.isEmpty {
            for stock in stocks {
                if stock.name.lowercased().contains(search.lowercased()) {
                    filtered.append(stock)
                }
            }
            stocks = filtered
        } else {
            interactor.loadStocks()
        }
    }

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
