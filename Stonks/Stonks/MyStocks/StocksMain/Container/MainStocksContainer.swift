import Foundation
import UIKit

class MainStocksContainer {
    let viewController: MainStocksViewController
    private(set) weak var router: MainStocksRouter?

    class func assemble(with context: MainStocksContext) -> MainStocksContainer {
//        let storyboard = UIStoryboard(name: Storyboard.mainStocks.name, bundle: nil)

//        guard let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.mainStocks.name) as? MainStocksViewController else {
//            fatalError("MyStocksContainer: viewController must be type MyStocksViewController")
//        }
        let viewController = MainStocksViewController()

        let router = MainStocksRouter()
        let interactor = MainStocksInteractor()
        let presenter = MainStocksPresenter(interactor: interactor)

        interactor.output = presenter

        viewController.output = presenter
        presenter.view = viewController

        router.viewController = viewController
        presenter.router = router

        return MainStocksContainer(view: viewController, router: router)
    }

    private init(view: MainStocksViewController, router: MainStocksRouter) {
        self.viewController = view
        self.router = router
    }
}

struct MainStocksContext {

}
