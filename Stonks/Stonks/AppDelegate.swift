import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        if StockDataService.shared.stockIsNew(symbol: "AAPL") {
            if let url = URL(string: "abC") {
                StockDataService.shared.createStock(name: "Apple", symbol: "AAPL", imageURL: url)
            }
        }
        self.window?.rootViewController = getInitalViewController(isAuthorized: AuthorizationService.shared.userIsAuthorized())

        self.window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    func getInitalViewController(isAuthorized: Bool) -> UIViewController {
        if isAuthorized {
            let tabBarVC = MainTabBar()

            tabBarVC.modalPresentationStyle = .fullScreen

            return tabBarVC
        } else {
            let context = LoginContext(isChecked: false)
            let container = LoginContainer.assemble(with: context)

            return container.viewController
        }
    }
}
