import Foundation

protocol MeHistoryInput: class {
    func reloadTable()
}

protocol MeHistoryOutput: class {
    func stock(at indexPath: IndexPath) -> StockHistoryData?
    func getNumberOfStocks() -> Int
    func didLoadView()
    func didFilterButtonTapped()
    func didSortedStocksLoaded(stocks: [StockHistoryData])
}

protocol MeHistoryRouterInput: class {
    func showFilter()
}

protocol MeHistoryInteractorInput: class {
    func loadStocks()
}

protocol MeHistoryInteractorOutput: class {
    func didReceive(stocks: [StockHistoryData])
}
