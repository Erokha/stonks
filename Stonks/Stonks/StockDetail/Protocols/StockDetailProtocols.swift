import Foundation
import Charts

protocol StockDetailViewInput: class {
    func setChartData(with quotes: [ChartDataEntry])
    func setNavigationBarTitle(with titel: String)
    func setStockNameLabel(with name: String)
    func setStockCurrentCostLabel(with cost: String)
    func showAlert(with title: String, message: String)
}

protocol StockDetailViewOutput: class {
    func didLoadView()
    func didTapBuyButton(amount: String?)
    func didTapSellButton(amount: String?)
    func viewWillDisappear()
    func didTapShowMyStocksButton()
}

protocol StockDetailRouterInput: class {
    func showMyStocksScreen()
}

protocol StockDetailInteractorInput: class {
    func increaseAmount(by value: Int)
    func descreaseAmount(by value: Int)
    func fetchStockQuotes()
    func stopFetching()
}

protocol StockDetailInteractorOutput: class {
    func freshCostDidReceived(model: StockDetailPresenterData)
    func stockHistoryDidReceived(model: StockDetailPresenterData)
    func showAlert(with title: String, message: String)
}
