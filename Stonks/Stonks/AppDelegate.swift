import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = getInitalViewController(isAuthorized: AuthorizationService.shared.userIsAuthorized())
        self.window?.makeKeyAndVisible()

        return true
    }
}

extension AppDelegate {
    func getInitalViewController(isAuthorized: Bool) -> UIViewController {
        if isAuthorized {
            return UIViewController()
        } else {
            let context = LoginContext(isChecked: true)
            let container = LoginContainer.assemble(with: context)

            return container.viewController
        }
    }
}
