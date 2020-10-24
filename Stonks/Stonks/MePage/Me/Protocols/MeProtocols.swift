import UIKit

protocol MeInput: class {
    func add(asChildViewController viewController: UIViewController)
    func remove(asChildViewController viewController: UIViewController)
    func setUserData(name: String, lastname: String, image: UIImage?)
    func setUserSpentInfo(spent: Int)
    func setUserCurrentBalance(currentBalance: Int)
}

protocol MeOutput: class {
    func didLoadView()
    func didIndexChanged(index: Int)
}

protocol MeRouterInput: class {
    func showPortfolio() -> MePortfolioViewController
    func showSettings() -> MeSettingsViewController
}
