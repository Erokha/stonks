import UIKit

class MeHistoryFilterContainer {
    let viewController: MeHistoryFilterViewController

    class func assemble(with context: MeHistoryFilterContext) -> MeHistoryFilterContainer {
        let storyboard = UIStoryboard(name: Storyboard.mePage.name, bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: Storyboard.meFilterPage.name) as? MeHistoryFilterViewController else {
            fatalError("MeHistoryFilterContainer: viewController must be type MeHistoryFilterViewController")
        }

        let presenter = MeHistoryFilterPresenter()

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
