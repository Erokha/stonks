import UIKit

class MyStocksPresenter: MyStocksViewOutput {
    var model: [Stock]?
    weak var view: MyStocksViewInput?

    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

    func stock(at indexPath: IndexPath) -> Stock? {
        return self.model?[indexPath.row] ?? nil
    }

}
