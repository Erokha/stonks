import UIKit

class MePortfolioContainer {
    let viewController: MePortfolioViewController
    private(set) weak var router: MePortfolioRouter?

    class func assemble(with context: MePortfolioContext) -> MePortfolioContainer {
        let vc = MePortfolioViewController()

        let presenter = MePortfolioPresenter()
        let router = MePortfolioRouter()

        vc.presenter = presenter
        presenter.view = vc
        presenter.router = router
        router.viewController = vc

        return MePortfolioContainer(view: vc, router: router)
    }

    private init(view: MePortfolioViewController, router: MePortfolioRouter) {
        self.viewController = view
        self.router = router
    }
}

struct MePortfolioContext {

}
