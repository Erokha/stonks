import UIKit

class MeRouter {
    weak var viewController: UIViewController?
}

extension MeRouter: MeRouterInput {
    func showSettings() -> MeSettingsViewController {
        let vc = MeSettingsContainer.asseble(with: MeSettingsContext()).viewController
        return vc
    }

    func showPortfolio() -> MePortfolioViewController {
        let vc = MePortfolioContainer.assemble(with: MePortfolioContext()).viewController
        return vc
    }
}
