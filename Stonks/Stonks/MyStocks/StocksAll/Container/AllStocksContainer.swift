import Foundation
import UIKit

class AllStocksContainer {
    let viewController: AllStocksViewController
    private(set) weak var router: StocksSharedRouter?// StocksRouter?

    class func assemble(with context: AllStocksContext) -> AllStocksContainer {

        let viewController = AllStocksViewController()

        let interactor = AllStocksInteractor()
        let presenter = AllStocksPresenter(interactor: interactor)

        interactor.output = presenter
        let router = StocksSharedRouter()// StocksRouter()

        viewController.output = presenter
        presenter.view = viewController

        presenter.router = router

        router.viewController = viewController

        return AllStocksContainer(view: viewController, router: router)
    }

    private init(view: AllStocksViewController, router: StocksSharedRouter) {
        self.viewController = view
        self.router = router
    }
}

struct AllStocksContext {

}
