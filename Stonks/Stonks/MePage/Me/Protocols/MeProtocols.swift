import UIKit

protocol MeInput: class {
    func setUserData(name: String, lastname: String, image: UIImage?)
    func setUserSpentInfo(spent: Int)
    func setUserCurrentBalance(currentBalance: Int)
    func setPage(with page: MePage)
}

protocol MeOutput: class {
    func didLoadView()
    func didIndexChanged(index: Int)
}

protocol MeRouterInput: class {
    func showPortfolio() -> MePortfolioViewController
    func showSettings() -> MeSettingsViewController
}

protocol MeInteractorInput: class {
    func loadUser()
}

protocol MeInteractorOutput: class {
    func didReceive(user: User)
}
