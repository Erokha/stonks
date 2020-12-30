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
    func didUserStartToSearch(search: String) {
        var filtered: [StockHistoryData] = []
        interactor.loadStocks()

        for stock in stocks {
            if stock.name.lowercased().contains(search.lowercased()) {
                filtered.append(stock)
            }
        }
        stocks = filtered
    }

    func didSortedStocksLoaded(stocks: [StockHistoryData]) {
        self.stocks = stocks
        var stockSymbols: [String] = []
        stocks.forEach({ stock in
            stockSymbols.append(stock.symbol)
        })
        interactor.loadImageUrl(for: Array(Set(stockSymbols)))
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
    func didReceiveImage(images: [String: String]) {
        var data = stocks
        for i in 0..<stocks.count {
            data[i].imageUrl = images[data[i].symbol]
        }
        self.stocks = data
    }

    func didReceive(newStocks: [StockHistoryData]) {
        self.stocks = newStocks
        var stockSymbols: [String] = []
        stocks.forEach({ stock in
            stockSymbols.append(stock.symbol)
        })
        interactor.loadImageUrl(for: Array(Set(stockSymbols)))
    }
}
