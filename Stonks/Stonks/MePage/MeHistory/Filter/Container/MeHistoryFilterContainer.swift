import UIKit

final class MeHistoryFilterContainer {
    let viewController: MeHistoryFilterViewController

    class func assemble(with context: MeHistoryFilterContext) -> MeHistoryFilterContainer {
        let vc = MeHistoryFilterViewController()
        let interactor = MeHistoryFilterInteractor()
        let presenter = MeHistoryFilterPresenter(interactor: interactor)

        interactor.output = presenter
        vc.output = presenter
        presenter.view = vc
        return MeHistoryFilterContainer(view: vc)
    }

    private init(view: MeHistoryFilterViewController) {
        self.viewController = view
    }
}

struct MeHistoryFilterContext {

}
