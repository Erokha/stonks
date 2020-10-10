import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Me", bundle: nil)

        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MePortfolio") as? MePortfolioViewController
        
        var model: [Stock] = []
        model.append(Stock(stockSymbol: "AAPL", stockprice: 200, numOfStocks: 10))
        model.append(Stock(stockSymbol: "Google", stockprice: 200, numOfStocks: 1))
        model.append(Stock(stockSymbol: "Yandex", stockprice: 300, numOfStocks: 2))
        model.append(Stock(stockSymbol: "Mail.ru", stockprice: 1000, numOfStocks: 2))
        
        initialViewController?.presenter = MePortfolioPresenter(view: initialViewController!, stocks: model, totalSpent: 10000)
//        let loginModel = Login()
//        initialViewController?.presenter = LoginPresenter(view: initialViewController!, model: loginModel)

        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
         
        return true
    }
}
