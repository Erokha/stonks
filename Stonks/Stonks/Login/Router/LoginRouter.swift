import Foundation
import UIKit

class LoginRouter {
    weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showMainScreen() {
        //let authScreen: UIViewController = LoginContainer.assemble(with: LoginContext(isChecked: true)).viewController
        let emptyVC = UIViewController()

        emptyVC.modalPresentationStyle = .fullScreen

        let navigationVC = UINavigationController(rootViewController: emptyVC)

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
