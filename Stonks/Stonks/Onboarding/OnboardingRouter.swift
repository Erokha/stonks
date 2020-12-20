import UIKit

final class OnboardingRouter {
    weak var viewController: UIViewController!
}

extension OnboardingRouter: OnboardingRouterInput {
    func showMainScreen() {
        let tabBarVC = MainTabBar()

        tabBarVC.modalPresentationStyle = .fullScreen

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        viewController.dismiss(animated: true, completion: nil)
        appDelegate.setRootViewController(viewController: tabBarVC)
    }
}
