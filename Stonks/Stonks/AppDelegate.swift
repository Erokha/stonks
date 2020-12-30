import UIKit
import Firebase
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        self.window?.rootViewController = getInitalViewController(isAuthorized: AuthorizationService.shared.userIsAuthorized())
        self.window?.makeKeyAndVisible()

        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID

        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance()?.handle(url) ?? false
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

    func setRootViewController(viewController: UIViewController) {
        self.window?.rootViewController = viewController
    }
}

extension AppDelegate {
    func reloadUserData() {
        AuthorizationService.shared.deAuthorize()

        let context = LoginContext(isChecked: false)
        let container = LoginContainer.assemble(with: context)

        setRootViewController(viewController: container.viewController)
    }
}
