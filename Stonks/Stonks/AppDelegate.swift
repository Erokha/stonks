import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Login", bundle: nil)

        let initialViewController = storyboard.instantiateViewController(withIdentifier: "Login") as? LoginViewController
        
        let loginModel = Login()
        initialViewController?.presenter = LoginPresenter(view: initialViewController!, model: loginModel)

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
         
        return true
    }
}
