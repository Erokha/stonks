import UIKit

protocol MyStocksViewInput: class {
    func setAvaliableBalance(balance: Int)
    func setStocksTotal(total: Int)
    func reloadTable()
    func startActivity()
    func endActivity()
}

protocol MyStocksViewOutput: class {
    func stock(at indexPath: IndexPath) -> Stock?
    func numberOfItems() -> Int
    func setBalance(num: Int)
    func setStocksTotal(num: Int)
    func didLoadView()
    func refreshData()
}

protocol MyStocksRouterInput: class {
    func showMainScreen()
    func showError(with error: Error)
}

protocol MyStoksInteractorInput: class {
    func loadStoks()
}

protocol MyStoksInteractorOutput: class {
    func didRecive(stoks: [Stock])
    func didReciveError(with error: Error)
}