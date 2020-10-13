import UIKit

class LoginRouter {
    weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showMainScreen() {
        let stockDetailVC: UIViewController = StockDetailContainer.assemble(with: StockDetailContext()).viewController

        stockDetailVC.modalPresentationStyle = .fullScreen

        let navigationVC = UINavigationController(rootViewController: stockDetailVC)

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
