import UIKit

class MainStocksRouter {
    weak var viewController: UIViewController?
}

extension MainStocksRouter: MainStocksRouterInput {
    func showAllStocks() -> AllStocksViewController {
        let viewController = AllStocksContainer.assemble(with: AllStocksContext()).viewController
        return viewController
    }

    func showUserStocks() -> UserStocksViewController {
        let viewController = UserStocksContainer.assemble(with: UserStocksContext()).viewController
        return viewController
    }

    func showError(with error: Error) {
        let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.viewController?.present(alert, animated: true)
    }
}
