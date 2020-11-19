import Foundation
import Charts

protocol StockDetailViewInput: class {
    func setChartData(with quotes: [ChartDataEntry])
    func setNavigationBarTitle(with titel: String)
    func setStockSymbolLabel(with name: String)
    func setCompanyNameLebel(with name: String)
    func setStockAmountLabel(with amount: String)
    func setStockCurrentCostLabel(with cost: String)
    func setCardLeftText(text: String)
    func setCardRightText(text: String)
    func setCardLeftNumber(number: Int)
    func setCardRightNumber(number: Int)
    func showAlert(with title: String, message: String)
    func disableKeyboard()
}

protocol StockDetailViewOutput: class {
    func didLoadView()
    func didTapView()
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
    func fetchStockData()
    func fetchCardData()
    func stopFetching()
}

protocol StockDetailInteractorOutput: class {
    func freshCostDidReceived(model: StockDetailPresenterData)
    func stockDataDidReceived(model: StockDetailPresenterData)
    func cardDataDidReceived(model: StockDetailPresenterData)
    func showAlert(with title: String, message: String)
}
