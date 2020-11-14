import UIKit

class StocksSharedRouter {
    weak var viewController: UIViewController?
}

extension StocksSharedRouter: StocksSharedRouterInput {
    func showError(with error: Error) {
        let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.viewController?.present(alert, animated: true)
    }

    func showStockDetail(symbol: String) {
        let container = StockDetailContainer.assemble(with: StockDetailContext(symbol: symbol))

        let vc = container.viewController

        vc.modalPresentationStyle = .fullScreen

        let navigationVC = UINavigationController(rootViewController: vc)

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
