import UIKit

class StockDetailContainer {
    let viewController: StockDetailViewController
    private weak var router: StockDetailRouter?

    class func assemble(with context: StockDetailContext) -> StockDetailContainer {
        let storyboard = UIStoryboard(name: Storyboard.stockDetail.name, bundle: nil)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.stockDetail.name) as? StockDetailViewController else {
            fatalError("StockDetailContainer: view controller must be type StockDetailViewController")
        }

        let model = StockDetailPresenterData(name: context.name)
        let presenter = StockDetailPresenter(model: model)
        let router = StockDetailRouter()
        let interactor = StockDetailInteractor(model: StockDetailInteractorData(name: context.name))

        viewController.output = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.viewConstroller = viewController

        interactor.output = presenter

        return StockDetailContainer(viewController: viewController, router: router)
    }

    private init(viewController: StockDetailViewController, router: StockDetailRouter) {
        self.viewController = viewController
        self.router = router
    }
}

struct StockDetailContext {
    var name: String
}
