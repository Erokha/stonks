import UIKit

enum MePage: Int {
    case mePortfolio = 0, meSettings
}

protocol MePageViewDelegate: class {
    func mePageViewControllerDidSet(with page: MePage)
}

final class MePageViewController: UIPageViewController {
    weak var mePageDelegate: MePageViewDelegate?

    lazy var pages: [UIViewController] = {
        let mePortfolioContainer = MePortfolioContainer.assemble(with: MePortfolioContext())
        let meSettingsContainer = MeSettingsContainer.asseble(with: MeSettingsContext())
        return [mePortfolioContainer.viewController, meSettingsContainer.viewController]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self

        setViewControllers([pages[0]], direction: .reverse, animated: false, completion: nil)
    }

    func setPage(for page: MePage) {
        let vc = pages[page.rawValue]
        switch page {
        case .mePortfolio:
            setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
        default:
            setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension MePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.firstIndex(of: viewController) else { return nil }

        let prevIndex = vcIndex - 1
        guard prevIndex >= 0 else {
            return nil
        }

        return pages[prevIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = vcIndex + 1
        guard nextIndex < pages.count else {
            return nil
        }

        return pages[nextIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        guard completed, let currVc = viewControllers?.first, let currIndex = pages.firstIndex(of: currVc) else {
            return
        }

        switch currIndex {
        case 0:
            mePageDelegate?.mePageViewControllerDidSet(with: .mePortfolio)
        case 1:
            mePageDelegate?.mePageViewControllerDidSet(with: .meSettings)
        default:
            return
        }
    }
}

extension MePageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}
