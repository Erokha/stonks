import UIKit

final class OnboardingRouter {
    weak var viewController: UIViewController!
}

extension OnboardingRouter: OnboardingRouterInput {
    func showMainScreen() {
        let tabBarVC = MainTabBar()

        tabBarVC.modalPresentationStyle = .fullScreen

        viewController?.present(tabBarVC, animated: true, completion: nil)
    }
}
