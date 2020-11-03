import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let url = URL(string: "ssdsd") else {
            return true
        }

        DataService.shared.createStock(name: "Aaple", symbol: "AAPL", curPrice: 10, imageURL: url)
        DataService.shared.createStock(name: "Masapo", symbol: "MOS", curPrice: 20, imageURL: url)
        DataService.shared.createStock(name: "Dojo", symbol: "DJ", curPrice: 150, imageURL: url)

        guard let stock1 = DataService.shared.getStock(with: "Aaple"),
              let stock2 = DataService.shared.getStock(with: "Masapo"),
              let stock3 = DataService.shared.getStock(with: "Dojo") else {
            return true
        }

        print(stock1.name)
        print(stock2.name)
        print(stock3.name)

        stock1.name = "first"
        stock2.name = "second"
        stock3.name = "third"

        DataService.shared.updateStock(name: "Aaple", stock: stock1)
        DataService.shared.updateStock(name: "Masapo", stock: stock1)
        DataService.shared.updateStock(name: "Dojo", stock: stock1)

        guard let stock4 = DataService.shared.getStock(with: "first"),
              let stock5 = DataService.shared.getStock(with: "second"),
              let stock6 = DataService.shared.getStock(with: "third") else {
            return true
        }

        print(stock4.name)
        print(stock5.name)
        print(stock6.name)

        guard let user = DataService.shared.getUser() else {
            print("no user")
            return true
        }

        print(user.stocks)

        DataService.shared.deleteStock(name: "first")
        DataService.shared.deleteStock(name: "second")
        DataService.shared.deleteStock(name: "third")

        self.window?.rootViewController = getInitalViewController(isAuthorized: DataService.shared.userIsAuthorized())

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
