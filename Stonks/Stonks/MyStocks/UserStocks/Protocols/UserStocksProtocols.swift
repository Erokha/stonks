import Foundation

protocol UserStocksViewInput: class {
    func reloadTable()
    func startActivity()
    func endActivity()
}

protocol UserStocksViewOutput: class {
    func stock(at indexPath: IndexPath) -> StockData?
    func numberOfItems() -> Int
    func didLoadView()
    func refreshData()
    func didTapOnStock(symbol: String)
}

protocol UserStoksInteractorInput: class {
    func loadStocksFromCoreData()
    func loadStoks(symbols: [String])
}

protocol UserStoksInteractorOutput: class {
    func didReciveUpdate(userStockUpdate: [String: Float])
    func didReciveCoreData(stocks: [StockData])
    func didReciveError(with error: Error)
}
