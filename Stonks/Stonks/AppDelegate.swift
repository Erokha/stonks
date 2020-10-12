import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "MyStocks", bundle: nil)

        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MyStocks") as? MyStocksViewController
        
        let model = [Stock(stockname: "Apple", stockSymbol: "AAPL", stockprice: 114.2, stockCount: 5, imageUrl: "none"), Stock(stockname: "Anal", stockSymbol: "ANL", stockprice: 300, stockCount: 1, imageUrl: "none")]
        initialViewController?.presenter = MyStocksPresenter(view: initialViewController!, model: model)

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
         
        return true
    }
}
