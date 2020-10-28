import UIKit

class MyStocksPresenter {
    var model: [Stock]?
    weak var view: MyStocksViewInput?
    var router: MyStocksRouterInput?
}

extension MyStocksPresenter: MyStocksViewOutput {
    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

    func stock(at indexPath: IndexPath) -> Stock? {
        return self.model?[indexPath.row] ?? nil
    }

    func setBalance(num: Int) {
        self.view?.setAvaliableBalance(balance: num)
    }

    func setStocksTotal(num: Int) {
        self.view?.setStocksTotal(total: num)
    }
}
