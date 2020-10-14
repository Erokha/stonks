import UIKit

protocol MyStocksViewOutput: class {
    func stock(at indexPath: IndexPath) -> Stock?
    func numberOfItems() -> Int
}
