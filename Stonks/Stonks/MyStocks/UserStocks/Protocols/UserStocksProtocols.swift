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
    var delegate: UserStocksDelegate? { get set }
    func routerHardResetUpdate()
}

protocol UserStoksInteractorInput: class {
    func loadStocksFromCoreData()
    func loadStoks(symbols: [String])
}

protocol UserStoksInteractorOutput: class {
    func didReciveUpdate(userStockUpdate: [String: (Float, String)])
    func didReciveCoreData(stocks: [StockData])
    func didReciveError(with error: Error)
    func requestUpdate()
}

protocol UserStocksDelegate: class {
    func getTotalStocksCount(with num: Int)
}
