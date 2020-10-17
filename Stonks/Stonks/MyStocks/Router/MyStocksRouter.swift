import UIKit

class MyStocksRouter {
    weak var viewController: UIViewController?
}

extension MyStocksRouter: MyStocksRouterInput {
    func showMainScreen() {

        let emptyVC = UIViewController()

        emptyVC.modalPresentationStyle = .fullScreen

        let navigationVC = UINavigationController(rootViewController: emptyVC)

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
