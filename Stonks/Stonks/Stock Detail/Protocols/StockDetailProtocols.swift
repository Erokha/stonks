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
}

protocol StockDetailRouterInput: class {

}

protocol StockDetailInteractorInput: class {
    func increaseAmount(for name: String, value: Int)
    func descreaseAmount(for name: String, value: Int)
    func fetchStockQuotes(for name: String)
    func fetchFreshCost(for name: String)
}

protocol StockDetailInteractorOutput: class {
    func freshCostDidReceived(cost: Double)
    func stockQuotesDidReceived(quotes: [(Double, Double)]?)
}
