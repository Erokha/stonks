import UIKit

class LoginRouter {
    weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showMainScreen() {
        let stockDetailVC: UIViewController = StockDetailContainer.assemble(with: StockDetailContext(name: "AAPL")).viewController

        let navigationVC = UINavigationController(rootViewController: stockDetailVC)
        navigationVC.modalPresentationStyle = .fullScreen

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
