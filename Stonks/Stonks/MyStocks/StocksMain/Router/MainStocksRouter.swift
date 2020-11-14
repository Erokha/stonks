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
}
