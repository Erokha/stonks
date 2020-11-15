import Foundation
import Charts

class StockDetailPresenter {

    weak var view: StockDetailViewInput?
    var router: StockDetailRouterInput?
    var interactor: StockDetailInteractorInput?

    private var model: StockDetailPresenterData

    init(model: StockDetailPresenterData) {
        self.model = model
    }

    deinit {
        print("presenter deinited")
    }
}

extension StockDetailPresenter: StockDetailViewOutput {
    func didLoadView() {
        interactor?.fetchCardData()
        interactor?.fetchStockQuotes()
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
    }
}

extension StockDetailPresenter: StockDetailInteractorOutput {
    func cardDataDidReceived(model: StockDetailPresenterData) {
        guard let data = model.cardData else {
            return
        }

        view?.setCardLeftNumber(number: data.leftNumber)
        view?.setCardRightNumber(number: data.rightNumber)
    }

    func freshCostDidReceived(model: StockDetailPresenterData) {
        self.model = model

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
        view?.setStockCurrentCostLabel(with: String(format: "%.1f", freshPrice.doubleValue) + "$")
    }

    func stockHistoryDidReceived(model: StockDetailPresenterData) {
        self.model = model

        guard let priceHistory = model.quotes,
              let freshPrice = priceHistory.last,
              let name = model.name else {
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
        view?.setStockNameLabel(with: name)
        view?.setStockCurrentCostLabel(with: String(format: "%.1f", freshPrice.doubleValue) + "$")
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
