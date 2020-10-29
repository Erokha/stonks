import UIKit

class MePresenter {
    weak var view: MeInput?
    var router: MeRouterInput?
    var settingsVc: MeSettingsViewController!
    var portfolioVc: MePortfolioViewController!
    private var interactor: MeInteractorInput

    var user: User? {
        didSet {
            let name = String(user?.name ?? "")
            let surname = String(user?.surname ?? "")
            let userBalance = Int(truncating: user?.balance ?? 0)
            let userSpent = Int(truncating: user?.totalSpent ?? 0)
            view?.setUserData(name: name, lastname: surname, image: nil)
            view?.setUserCurrentBalance(currentBalance: userBalance)
            view?.setUserSpentInfo(spent: userSpent)
        }
    }

    init(interactor: MeInteractorInput) {
        self.interactor = interactor
    }
}

extension MePresenter: MeOutput {
   func didIndexChanged(index: Int) {
        switch index {
        case 0:
            view?.setPage(with: .mePortfolio)
        case 1:
            view?.setPage(with: .meSettings)
        default:
            break
        }
    }

    func didLoadView() {
        guard let settingsViewController = router?.showSettings() else { return }
        guard let portfolioViewController = router?.showPortfolio() else { return }
        settingsVc = settingsViewController
        portfolioVc = portfolioViewController
        // load data about user
        interactor.loadUser()
    }
}

extension MePresenter: MeInteractorOutput {
    func didReceive(user: User) {
        self.user = user
    }
}
