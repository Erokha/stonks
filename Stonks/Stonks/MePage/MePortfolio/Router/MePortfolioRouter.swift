import UIKit

class MePortfolioRouter {
    weak var viewController: UIViewController?
}

extension MePortfolioRouter: MePortfolioRouterInput {
    func showHistory() {
        let container = MeHistoryContainer.assemble(with: MeHistoryContext())

        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }
}
