import UIKit

final class MeHistoryContainer {
    let viewController: MeHistoryViewController
    private(set) weak var router: MeHistoryRouter?

    class func assemble(with context: MeHistoryContext) -> MeHistoryContainer {
        let vc = MeHistoryViewController()

        let interactor = MeHistoryInteractor()
        let presenter = MeHistoryPresenter(interactor: interactor)
        let router = MeHistoryRouter()

        presenter.view = vc
        presenter.router = router
        vc.output = presenter
        interactor.output = presenter
        router.viewController = vc

        return MeHistoryContainer(viewController: vc, router: router)
    }

    private init(viewController: MeHistoryViewController, router: MeHistoryRouter) {
        self.viewController = viewController
        self.router = router
    }
}

struct MeHistoryContext {

}
