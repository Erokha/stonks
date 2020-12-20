import UIKit

final class OnboardingPageViewController: UIPageViewController {

    private var router: OnboardingRouterInput!

    private var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPages()
        setupPageView()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        updateView()
    }

    private func updateView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func setupPages() {
        pages.append(contentsOf: [setupFirstPage(), setupSecondPage(), setupThirdPage()])
    }

    private func setupFirstPage() -> UIViewController {
        let viewController = FirstPageViewController()

        viewController.delegate = self

        return viewController
    }

    private func setupSecondPage() -> UIViewController {
        let viewController = SecondPageViewController()

        viewController.delegate = self

        return viewController
    }

    private func setupThirdPage() -> UIViewController {
        let viewController = ThirdPageViewController()

        viewController.delegate = self
        return viewController
    }

    private func setupPageView() {
        view.backgroundColor = Constants.backgroundColor

        dataSource = self
        delegate = self

        let router = OnboardingRouter()

        router.viewController = self
        self.router = router

        setViewControllers([pages[.zero]], direction: .forward, animated: true, completion: nil)
    }

    private func onboardingDidFinished() {
        router?.showMainScreen()
    }
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.firstIndex(of: viewController),
              vcIndex - 1 >= .zero else {
            return nil
        }

        return pages[vcIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.firstIndex(of: viewController),
              vcIndex + 1 < pages.count else {
            return nil
        }

        return pages[vcIndex + 1]
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}

extension OnboardingPageViewController: PageControllerDelegate {
    func showNextPage() {
        guard let vcIndex = pages.firstIndex(of: viewControllers?.first ?? UIViewController()),
              vcIndex + 1 < pages.count else {
            onboardingDidFinished()
            return
        }

        setViewControllers([pages[vcIndex + 1]], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardingPageViewController {
    private struct Constants {
        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 1)
            } else {
                return .white
            }
        }
    }
}
