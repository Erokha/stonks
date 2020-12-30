import UIKit

class MainTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        prepareViewControllers()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        tabBar.backgroundColor = Constants.backgroundColor
    }

    private func setupTabBar() {
        tabBar.backgroundColor = Constants.backgroundColor
        tabBar.tintColor = Constants.tintColor
        tabBar.unselectedItemTintColor = Constants.tintColor
    }

    private func prepareViewControllers() {
        viewControllers = [prepareLearnViewController(),
                           prepareMyStocksViewController(),
                           prepareNewsViewController(),
                           prepareMePortfoiolViewController()]
    }

    private func prepareLearnViewController() -> UINavigationController {
        let container = ArticleContainer.assemble(with: ArticleContext(tableViewTitle: "Learn", type: .learn))
        let tabBarItem = UITabBarItem(title: Constants.LearnBarItem.title,
                                      image: UIImage(named: Constants.LearnBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.LearnBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareMyStocksViewController() -> UINavigationController {
        let container = MainStocksContainer.assemble(with: MainStocksContext())
        let tabBarItem = UITabBarItem(title: Constants.MyStocksBarItem.title,
                                      image: UIImage(named: Constants.MyStocksBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.MyStocksBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareNewsViewController() -> UINavigationController {
        let container = ArticleContainer.assemble(with: ArticleContext(tableViewTitle: "News", type: .news))
        let tabBarItem = UITabBarItem(title: Constants.NewsBarItem.title,
                                      image: UIImage(named: Constants.NewsBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.NewsBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareMePortfoiolViewController() -> UINavigationController {
        let container = MeContainer.assemble(with: MeContext())
        let tabBarItem = UITabBarItem(title: Constants.MeBarItem.title,
                                      image: UIImage(named: Constants.MeBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.MeBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }
}

extension MainTabBar {
    private struct Constants {
        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 72 / 255,
                               green: 69 / 255,
                               blue: 84 / 255,
                               alpha: 1)
            } else {
                return UIColor(red: 249 / 255,
                               green: 249 / 255,
                               blue: 249 / 255,
                               alpha: 1)
            }
        }

        static let tintColor: UIColor = UIColor(red: 113 / 255,
                                                green: 101 / 255,
                                                blue: 227 / 255,
                                                alpha: 1)

        struct LearnBarItem {
            static let title: String = "Learn"
            static let imageName: String = "learn"
            static let tag: Int = 0
        }

        struct MyStocksBarItem {
            static let title: String = "Stocks"
            static let imageName: String = "stocks"
            static let tag: Int = 1
        }

        struct NewsBarItem {
            static let title: String = "News"
            static let imageName: String = "news"
            static let tag: Int = 2
        }

        struct MeBarItem {
            static let title: String = "Me"
            static let imageName: String = "me"
            static let tag: Int = 3
        }
    }
}
