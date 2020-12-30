import UIKit

final class LoginRouter {
    weak var viewController: UIViewController?
}

extension LoginRouter: LoginRouterInput {
    func showMainScreen() {
        let tabBarVC = MainTabBar()

        tabBarVC.modalPresentationStyle = .fullScreen

        viewController?.present(tabBarVC, animated: true, completion: nil)
    }

    func showOnboarding() {
        let pageController = OnboardingPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal,
                                                          options: nil)

        pageController.modalPresentationStyle = .fullScreen

        viewController?.present(pageController, animated: true, completion: nil)
    }

    func showTermsAndConditions() {
        let termsController = TermsConditionsViewController()

        viewController?.present(termsController, animated: true, completion: nil)
    }
}
