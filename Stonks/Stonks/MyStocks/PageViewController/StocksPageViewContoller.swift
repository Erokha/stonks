import UIKit

enum StocksPage: Int {
    case allStocks = 0, userStocks
}

protocol StocksPageViewDelegate: class {
    func stocksPageViewControllerDidSet(with page: StocksPage)
}

final class StocksPageViewController: UIPageViewController {
    weak var stocksPageDelegate: StocksPageViewDelegate?

    lazy var pages: [UIViewController] = {
        let userStocksContainer = UserStocksContainer.assemble(with: UserStocksContext())
        let allStocksContainer = AllStocksContainer.assemble(with: AllStocksContext())
        return [userStocksContainer.viewController, allStocksContainer.viewController]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self

        setViewControllers([pages[0]], direction: .reverse, animated: false, completion: nil)
    }

    func setPage(for page: StocksPage) {
        let vc = pages[page.rawValue]
        switch page {
        case .allStocks:
            setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
        default:
            setViewControllers([vc], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension StocksPageViewController: UIPageViewControllerDataSource {
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
            stocksPageDelegate?.stocksPageViewControllerDidSet(with: .allStocks)
        case 1:
            stocksPageDelegate?.stocksPageViewControllerDidSet(with: .userStocks)
        default:
            return
        }
    }
}

extension StocksPageViewController: UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
}
