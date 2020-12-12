import Foundation
import Charts

protocol StockDetailViewInput: AnyObject {
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

    func showActivityIndicator()

    func hideActivityIndicator()

    func getLineChartViewSize() -> CGSize

    func showPointInfo(percentageX: CGFloat, percentageY: CGFloat, cost: String)

    func disableKeyboard()
}

protocol StockDetailChartViewInput: AnyObject {
    func configure(text: String, percentageX: CGFloat, percentageY: CGFloat)
}

protocol StockDetailViewOutput: class {
    func didLoadView()

    func didTapView()

    func didTapBuyButton(amount: String?)

    func didTapSellButton(amount: String?)

    func viewWillDisappear()

    func didTapShowMyStocksButton()

    func didTapLineChartView(location: CGPoint)
}

protocol StockDetailRouterInput: AnyObject {
    func showMyStocksScreen()
}

protocol StockDetailInteractorInput: AnyObject {
    func increaseAmount(by value: Int)

    func descreaseAmount(by value: Int)

    func fetchStockData()

    func fetchBalance()

    func fetchAmountPrice()

    func stopFetching()
}

protocol StockDetailInteractorOutput: AnyObject {
    func freshCostDidReceived(model: StockPresenterData)

    func stockDataDidReceived(model: StockPresenterData)

    func amountPriceUpdateDidReceived(amountPrice: Int)

    func balanceUpdateDidReceived(balance: Int)

    func stockAmountUpdated(model: StockPresenterData)

    func showAlert(with title: String, message: String)
}
