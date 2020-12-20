import UIKit

class UserStocksContainer {
    let viewController: UserStocksViewController
    private(set) weak var router: StocksSharedRouter?// MyStocksRouter?

    class func assemble(with context: UserStocksContext) -> UserStocksContainer {
        let viewController = UserStocksViewController()
        let interactor = UserStocksInteractor()
        let presenter = UserStocksPresenter(interactor: interactor)

        interactor.output = presenter
        let router = StocksSharedRouter()// MyStocksRouter()

        viewController.output = presenter
        presenter.view = viewController

        presenter.router = router

        router.viewController = viewController

        return UserStocksContainer(view: viewController, router: router)
    }

    private init(view: UserStocksViewController, router: StocksSharedRouter) {
        self.viewController = view
        self.router = router
    }
}

struct UserStocksContext {

}
