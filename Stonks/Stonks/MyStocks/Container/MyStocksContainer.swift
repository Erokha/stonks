import Foundation
import UIKit

class MyStocksContainer {
    let viewController: MyStocksViewController
    private(set) weak var router: MyStocksRouter?

    class func assemble(with context: MyStocksContext) -> MyStocksContainer {
        let storyboard = UIStoryboard(name: Storyboard.myStocks.name, bundle: nil)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.myStocks.name) as? MyStocksViewController else {
            fatalError("MyStocksContainer: viewController must be type MyStocksViewController")
        }

        //let model: [Stock?] = []//here would be model or not???

        let interactor = MyStocksInteractor()
        let presenter = MyStocksPresenter(interactor: interactor)

        interactor.output = presenter
        let router = MyStocksRouter()

        viewController.output = presenter
        presenter.view = viewController

        presenter.router = router

        router.viewController = viewController

        return MyStocksContainer(view: viewController, router: router)
    }

    private init(view: MyStocksViewController, router: MyStocksRouter) {
        self.viewController = view
        self.router = router
    }
}

struct MyStocksContext {
    var testmodel: [StockData]?
}
