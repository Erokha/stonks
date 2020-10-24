import UIKit

class MePresenter {
    weak var view: MeInput?
    var router: MeRouterInput?
    var settingsVc: MeSettingsViewController!
    var portfolioVc: MePortfolioViewController!

    required init() {
    }
}

extension MePresenter: MeOutput {
   func didIndexChanged(index: Int) {
        switch index {
        case 0:
            view?.remove(asChildViewController: settingsVc)
            view?.add(asChildViewController: portfolioVc)
        case 1:
            view?.remove(asChildViewController: portfolioVc)
            view?.add(asChildViewController: settingsVc)
        default:
            break
        }
    }

    func didLoadView() {
        guard let settingsViewController = router?.showSettings() else { return }
        guard let portfolioViewController = router?.showPortfolio() else { return }
        settingsVc = settingsViewController
        portfolioVc = portfolioViewController
        view?.add(asChildViewController: portfolioViewController)
        // load data about user
        view?.setUserData(name: "Sasha", lastname: "Zak", image: UIImage(named: "ZUEV"))
        view?.setUserSpentInfo(spent: 200)
        view?.setUserCurrentBalance(currentBalance: 1200)
    }
}
