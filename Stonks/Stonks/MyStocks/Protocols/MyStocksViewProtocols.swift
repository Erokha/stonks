import UIKit

protocol MyStocksViewInput: class {
    func setAvaliableBalance(balance: Int)
    func setStocksTotal(total: Int)
    func reloadTable()
    func startActivity()
    func endActivity()
}

protocol MyStocksViewOutput: class {
    func stock(at indexPath: IndexPath) -> StockData?
    func numberOfItems() -> Int
    func setBalance(num: Int)
    func setStocksTotal(num: Int)
    func didLoadView()
    func refreshData()
}

protocol MyStocksRouterInput: class {
    func showStockDetail()
    func showError(with error: Error)
}

protocol MyStoksInteractorInput: class {
    func loadStoks()
}

protocol MyStoksInteractorOutput: class {
    func didRecive(stoks: [StockData])
    func didReciveError(with error: Error)
}
