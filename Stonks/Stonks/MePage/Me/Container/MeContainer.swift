import UIKit

final class MeContainer {
    let viewController: MeViewController
    private(set) weak var router: MeRouter?

    class func assemble(with context: MeContext) -> MeContainer {
        let vc = MeViewController()

        let interactor = MeInteractor()
        let presenter = MePresenter(interactor: interactor)
        let router = MeRouter()

        vc.presenter = presenter
        presenter.view = vc
        presenter.router = router
        interactor.output = presenter
        router.viewController = vc
        return MeContainer(view: vc, router: router)
    }

    private init(view: MeViewController, router: MeRouter) {
        self.viewController = view
        self.router = router
    }
}

struct MeContext {

}
