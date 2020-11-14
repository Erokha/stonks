import UIKit

class MyStocksRouter {
    weak var viewController: UIViewController?
}

extension MyStocksRouter: MyStocksRouterInput {
    func showStockDetail(symbol: String) {
        let container = StockDetailContainer.assemble(with: StockDetailContext(symbol: symbol))
        let vc = container.viewController

        vc.modalPresentationStyle = .fullScreen

        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func showError(with error: Error) {
        let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.viewController?.present(alert, animated: true)
    }

    func showStockDetail() {

        let emptyVC = UIViewController()

        emptyVC.modalPresentationStyle = .fullScreen

        let navigationVC = UINavigationController(rootViewController: emptyVC)

        viewController?.present(navigationVC, animated: true, completion: nil)
    }
}
