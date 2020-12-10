import UIKit

final class MeHistoryContainer {
    let viewController: MeHistoryViewControllerPin
    private(set) weak var router: MeHistoryRouter?

    class func assemble(with context: MeHistoryContext) -> MeHistoryContainer {
        let vc = MeHistoryViewControllerPin()
//        let storyboard = UIStoryboard(name: Storyboard.mePage.name, bundle: nil)
//        guard let vc = storyboard.instantiateViewController(withIdentifier: Storyboard.meHistoryPage.name) as? MeHistoryViewController else {
//            fatalError("MeHistoryContainer: viewController must be type MeHistoryViewController")}

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

    private init(viewController: MeHistoryViewControllerPin, router: MeHistoryRouter) {
        self.viewController = viewController
        self.router = router
    }
}

struct MeHistoryContext {

}
