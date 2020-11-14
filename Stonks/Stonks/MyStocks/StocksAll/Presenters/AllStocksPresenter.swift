import UIKit
import Alamofire

class AllStocksPresenter {
    var model: [StockData]? {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    weak var view: AllStocksViewInput?
    var router: StocksSharedRouterInput?
    private let interactor: AllStoksInteractorInput

    init(interactor: AllStoksInteractorInput) {
        self.interactor = interactor
    }

}

extension AllStocksPresenter: AllStocksViewOutput {
    func didTapOnStock(symbol: String) {
        router?.showStockDetail(symbol: symbol)
    }

    func didLoadView() {
        view?.startActivity()
        interactor.loadStoks()
    }

    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

    func stock(at indexPath: IndexPath) -> StockData? {
        return self.model?[indexPath.row] ?? nil
    }

    func refreshData() {
        self.interactor.loadStoks()
    }
}

extension AllStocksPresenter: AllStoksInteractorOutput {

    func didRecive(stoks: [StockData]) {
        self.model = stoks
        view?.endActivity()
    }

    func didReciveError(with error: Error) {
        router?.showError(with: error)
        view?.endActivity()
    }

}

public enum AppError: Error {
    case networkError
    case undefinedError
}

extension AppError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("Network connection lost", comment: "")

        case .undefinedError:
            return NSLocalizedString("Error occured", comment: "")
        }
    }
}
