import UIKit

final class MeRouter {
    weak var viewController: UIViewController?
}

extension MeRouter: MeRouterInput {
    func show(alert: UIAlertController) {
        viewController?.present(alert, animated: true)
    }
}
