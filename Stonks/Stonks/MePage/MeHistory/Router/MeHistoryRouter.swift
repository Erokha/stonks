import Foundation

final class MeHistoryRouter {
    weak var viewController: MeHistoryViewController?

}

extension MeHistoryRouter: MeHistoryRouterInput {
    func showFilter() {
        let container = MeHistoryFilterContainer.assemble(with: MeHistoryFilterContext())

        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
