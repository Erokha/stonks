import UIKit
import Alamofire

class MyStocksPresenter {
    var model: [StockData]? {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    weak var view: MyStocksViewInput?
    var router: MyStocksRouterInput?
    private let interactor: MyStoksInteractorInput

    init(interactor: MyStoksInteractorInput) {
        self.interactor = interactor
    }

}

extension MyStocksPresenter: MyStocksViewOutput {
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

    func setBalance(num: Int) {
        self.view?.setAvaliableBalance(balance: num)
    }

    func setStocksTotal(num: Int) {
        self.view?.setStocksTotal(total: num)
    }

    func refreshData() {
        self.interactor.loadStoks()
    }

    func didTapOnStock(symbol: String) {
            router?.showStockDetail(symbol: symbol)
    }
}

extension MyStocksPresenter: MyStoksInteractorOutput {

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
