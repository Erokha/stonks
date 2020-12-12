import Foundation

final class MeHistoryRouter {
    weak var viewController: MeHistoryViewController?

}

extension MeHistoryRouter: MeHistoryRouterInput {
    func showFilter() {
        let vc = MeHistoryFilterContainer.assemble(with: MeHistoryFilterContext()).viewController
        vc.meHistoryFilterDelegate = viewController
        viewController?.navigationController?.pushViewController(vc, animated: true)

    }
}
