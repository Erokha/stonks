import UIKit

protocol MainStocksViewInput: class {
    func setAvaliableBalance(num: Int)
    func setStocksTotal(num: Int)
    func setPage(with page: StocksPage)
}

protocol MainStocksViewOutput: class {
    func didLoadView()
    func didIndexChanged(index: Int)
}

protocol MainStocksRouterInput: class {
    func showAllStocks() -> AllStocksViewController
    func showUserStocks() -> UserStocksViewController
    func showError(with error: Error)
}

protocol MainStocksInteractorInput: class {
    func loadUser()
    // func loadStocks()
}

protocol MainStocksInteractorOutput: class {
    // var model: [StockData]? { get set }
    func didReceive(user: MeUserData)
   // func handleFreshStocks(data: [String: Float])
    func didReciveError(with error: Error)
}
