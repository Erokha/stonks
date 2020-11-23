import UIKit

class StocksSharedRouter {
    weak var viewController: UIViewController?
    var needToShowError: Bool = true
}

extension StocksSharedRouter: StocksSharedRouterInput {
    func showError(with error: Error) {
        if needToShowError {
            let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

            self.viewController?.present(alert, animated: true)
            needToShowError = false
        }
    }

    func showStockDetail(symbol: String) {
        let container = StockDetailContainer.assemble(with: StockDetailContext(symbol: symbol))

        let vc = container.viewController

        vc.modalPresentationStyle = .fullScreen

        viewController?.navigationItem.backButtonTitle = "printf(\"Jopa\n\");"

        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func hardResetUpdateFlag() {
        needToShowError = true
    }
}
