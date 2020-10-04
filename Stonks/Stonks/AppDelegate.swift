import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let loginViewModel = LoginViewModel()
        let loginVC = LoginViewController()
        loginVC.viewModel = loginViewModel
        
        window?.rootViewController = loginVC
        window?.makeKeyAndVisible()
         
        return true
    }
}
