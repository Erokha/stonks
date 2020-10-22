import UIKit

protocol MeInput: class {
    func add(asChildViewController viewController: UIViewController)
    func remove(asChildViewController viewController: UIViewController)
}

protocol MeOutput: class {
    func didLoadView()
    func didIndexChanged(index: Int)
}

protocol MeRouterInput: class {
    func showPortfolio() -> MePortfolioViewController
    func showSettings() -> MeSettingsViewController
}
