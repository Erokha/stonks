import UIKit

class MePresenter {
    weak var view: MeInput?
    var router: MeRouterInput?
    var settingsVc: MeSettingsViewController!
    var portfolioVc: MePortfolioViewController!
    private var iteractor: MeInteractorInput

    var user: User?

    init(interactor: MeInteractorInput) {
        self.iteractor = interactor
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
        view?.setUserData(name: "Sasha", lastname: "Zak", image: UIImage(named: "ZUEV"))
        view?.setUserSpentInfo(spent: 200)
        view?.setUserCurrentBalance(currentBalance: 1200)
    }
}

extension MePresenter: MeInteractorOutput {
    func didReceive(user: User) {
        self.user = user
    }
}
