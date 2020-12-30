import Foundation
import Charts

final class StockDetailPresenter {

    weak var view: StockDetailViewInput?
    var router: StockDetailRouterInput?
    var interactor: StockDetailInteractorInput?

    private var model: StockPresenterData

    init(model: StockPresenterData) {
        self.model = model
    }
}

extension StockDetailPresenter: StockDetailViewOutput {
    func didLoadView() {
        view?.showActivityIndicator()
        interactor?.fetchStockData()
    }

    func didTapView() {
        view?.disableKeyboard()
    }

    func didTapBuyButton(amount: String?) {
        guard let amountString = amount,
              !amountString.isEmpty else {
            view?.showAlert(with: "Oops!", message: "Stock amount not inputed")
            return
        }

        guard let amount = Int(amountString) else {
            view?.showAlert(with: "Oops!", message: "Unreal to convert amount to number")
            return
        }

        interactor?.increaseAmount(by: amount)
        interactor?.fetchAmountPrice()
    }

    func didTapSellButton(amount: String?) {
        guard let amountString = amount,
              !amountString.isEmpty else {
            view?.showAlert(with: "Oops!", message: "Stock amount not inputed")
            return
        }

        guard let amount = Int(amountString) else {
            view?.showAlert(with: "Oops!", message: "Unreal to convert amount to number")
            return
        }

        interactor?.descreaseAmount(by: amount)
        interactor?.fetchAmountPrice()
    }

    func didTapLineChartView(location: CGPoint) {
        guard let size = view?.getLineChartViewSize(),
              let quotes = model.quotes else {
            return
        }

        let percentageX = location.x / size.width
        let index = Int((percentageX * CGFloat(quotes.count - 1)).rounded())

        var minCost = quotes[.zero].floatValue
        var maxCost = quotes[.zero].floatValue

        quotes.forEach { quote in
            let floatQuote = quote.floatValue

            if floatQuote < minCost {
                minCost = floatQuote
            } else if floatQuote > maxCost {
                maxCost = floatQuote
            }
        }

        let cost = quotes[index].floatValue
        var percentageY: CGFloat = 0.5

        if abs(CGFloat(maxCost - minCost)) > Constants.eps {
            percentageY = 1 - CGFloat((cost - minCost) / (maxCost - minCost))
        }

        view?.showPointInfo(percentageX: percentageX,
                            percentageY: percentageY,
                            cost: String(format: "%.2f", cost) + "$")
    }
}

extension StockDetailPresenter: StockDetailInteractorOutput {
    func balanceUpdateDidReceived(balance: Int) {
        view?.setCardLeftNumber(number: balance)
    }

    func amountPriceUpdateDidReceived(amountPrice: Int) {
        view?.setCardRightNumber(number: amountPrice)
    }

    func freshCostDidReceived(model: StockPresenterData) {
        self.model = model

        interactor?.fetchAmountPrice()

        guard let priceHistory = model.quotes,
              let freshPrice = priceHistory.last else {
            return
        }

        var chartPoints: [(Double, Double)] = []

        for i in 0..<priceHistory.count {
            chartPoints.append((Double(i), priceHistory[i].doubleValue))
        }

        let chartData = chartPoints.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        })

        view?.setChartData(with: chartData)
        view?.setStockCurrentCostLabel(with: String(format: "%.2f", freshPrice.doubleValue) + "$")
    }

    func stockAmountUpdated(model: StockPresenterData) {
        guard let amount = model.amount else {
            return
        }

        view?.setStockAmountLabel(with: String(amount))
    }

    func stockDataDidReceived(model: StockPresenterData) {
        self.model = model

        interactor?.fetchAmountPrice()
        interactor?.fetchBalance()

        guard let priceHistory = model.quotes,
              let freshPrice = priceHistory.last,
              let amount = model.amount,
              let name = model.name,
              let symbol = model.symbol else {
            return
        }

        var chartPoints: [(Double, Double)] = []

        for i in 0..<priceHistory.count {
            chartPoints.append((Double(i), priceHistory[i].doubleValue))
        }

        let chartData = chartPoints.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        })

        view?.setChartData(with: chartData)
        view?.setStockSymbolLabel(with: symbol)
        view?.setCompanyNameLebel(with: name)
        view?.setStockAmountLabel(with: String(amount))
        view?.setStockCurrentCostLabel(with: String(format: "%.2f", freshPrice.doubleValue) + "$")

        view?.hideActivityIndicator()
    }

    func showAlert(with title: String, message: String) {
        view?.showAlert(with: title, message: message)
    }

    func didTapShowMyStocksButton() {
        router?.showMyStocksScreen()
    }

    func viewWillDisappear() {
        interactor?.stopFetching()
    }
}

extension StockDetailPresenter {
    private struct Constants {
        static let eps: CGFloat = 0.000001
    }
}
