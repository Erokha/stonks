import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Me", bundle: nil)

        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MePortfolio") as? MePortfolioViewController
        
//        let loginModel = Login()
//        initialViewController?.presenter = LoginPresenter(view: initialViewController!, model: loginModel)

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
         
        return true
    }
}
