import UIKit

protocol AllStocksViewInput: class {
    func reloadTable()
    func startActivity()
    func endActivity()
}

protocol AllStocksViewOutput: class {
    func stock(at indexPath: IndexPath) -> StockData?
    func numberOfItems() -> Int
    func didLoadView()
    func refreshData()
    func didTapOnStock(symbol: String)
    func routerHardResetUpdate()
}

protocol StocksSharedRouterInput: class {
    func showError(with error: Error)
    func showStockDetail(symbol: String)
    func hardResetUpdateFlag()
}

protocol AllStoksInteractorInput: class {
    func loadStoks()
}

protocol AllStoksInteractorOutput: class {
    func didRecive(stoks: [StockData])
    func didReciveError(with error: Error)
}
