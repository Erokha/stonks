import UIKit

protocol MyStocksViewOutput: class {
    func stock(at indexPath: IndexPath) -> Stock?
    func numberOfItems() -> Int
    func setBalance(num: Int)
    func setStocksTotal(num: Int)
    func didLoadView()
    func refreshData()
}
