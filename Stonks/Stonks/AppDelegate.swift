import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let context = MePortfolioContext()
        let container = MePortfolioContainer.assemble(with: context)
        window?.rootViewController = container.viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
