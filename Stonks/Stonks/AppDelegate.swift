import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

//        let currentDate: Date = Date()
//        StockHistoryDataService.shared.createHistoryStock(name: "Abc", symbol: "Lal", price: 130, date: currentDate, type: .bought)

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
