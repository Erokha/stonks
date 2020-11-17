import UIKit

final class StockDetailRouter {
    weak var viewConstroller: UIViewController?
}

extension StockDetailRouter: StockDetailRouterInput {
    func showMyStocksScreen() {
        viewConstroller?.navigationController?.popViewController(animated: true)
    }
}
