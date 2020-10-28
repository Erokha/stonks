import Foundation
import UIKit

class LoginRouter {
    weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showMainScreen() {
        let emptyVC = UIViewController()

        let navigationVC = UINavigationController(rootViewController: emptyVC)
        navigationVC.modalPresentationStyle = .fullScreen

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
