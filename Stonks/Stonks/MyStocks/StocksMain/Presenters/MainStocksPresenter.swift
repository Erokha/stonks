import UIKit

class MainStocksPresenter {
    var router: MainStocksRouterInput?
    weak var view: MainStocksViewInput?
    private var interactor: MainStocksInteractorInput
    private var shouldUpdateData: Bool

    init(interactor: MainStocksInteractorInput) {
        self.interactor = interactor
        shouldUpdateData = false
    }
}

extension MainStocksPresenter: MainStocksViewOutput {
    func didLoadView() {
        shouldUpdateData = true
        interactor.loadUser()
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

extension MainStocksPresenter: MainStocksInteractorOutput {
    func didReceive(user: MeUserData) {
        if shouldUpdateData {
            self.view?.setAvaliableBalance(num: user.balance)
        }
    }
}
