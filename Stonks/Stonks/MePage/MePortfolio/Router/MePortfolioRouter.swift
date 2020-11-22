import UIKit

class MePortfolioRouter {
    weak var viewController: UIViewController?
}

extension MePortfolioRouter: MePortfolioRouterInput {
    func showHistory() {
        let container = MeHistoryContainer.assemble(with: MeHistoryContext())

        viewController?.navigationController?.pushViewController(container.viewController, animated: true)
    }

    func showError(with error: Error) {
        let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.viewController?.present(alert, animated: true)
    }
}
