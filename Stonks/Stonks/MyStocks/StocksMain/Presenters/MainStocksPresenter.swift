import UIKit

class MainStocksPresenter {
    var router: MainStocksRouterInput?
    weak var view: MainStocksViewInput?
    var allStocksViewController: AllStocksViewController!
    var userStocksViewController: UserStocksViewController!
}

extension MainStocksPresenter: MainStocksViewOutput {
    func didLoadView() {
        guard let allvc = router?.showAllStocks() else { return }
        guard let uservc = router?.showUserStocks() else { return }
        allStocksViewController = allvc
        userStocksViewController = uservc
    }

    func didIndexChanged(index: Int) {
         switch index {
         case 0:
            view?.setPage(with: .allStocks)
         case 1:
             view?.setPage(with: .userStocks)
         default:
             break
         }
     }
}
