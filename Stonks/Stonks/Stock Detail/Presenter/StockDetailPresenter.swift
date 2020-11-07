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
}

extension StockDetailPresenter: StockDetailViewOutput {
    func didLoadView() {
        interactor?.fetchStockQuotes(for: model.name)
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

        interactor?.increaseAmount(for: model.name, value: amount)
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

        interactor?.descreaseAmount(for: model.name, value: amount)
    }
}

extension StockDetailPresenter: StockDetailInteractorOutput {
    func freshCostDidReceived(model: StockDetailPresenterData) {
        self.model = model

        guard let freshPrice = model.freshPrice else {
            return
        }

        guard let chartData = self.model.quotes?.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        }) else {
            return
        }

        view?.setChartData(with: chartData)
        view?.setStockCurrentCostLabel(with: String(format: "%.1f", NSDecimalNumber(decimal: freshPrice).doubleValue) + "$")
    }

    func stockQuotesDidReceived(model: StockDetailPresenterData) {
        self.model = model

        guard let chartData = model.quotes?.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        }) else {
            print("Data not fetched")
            return
        }

        guard let currentCost = chartData.last?.y else {
            return
        }

        view?.setChartData(with: chartData)
        view?.setNavigationBarTitle(with: model.name)
        view?.setStockNameLabel(with: model.name)
        view?.setStockCurrentCostLabel(with: String(format: "%.1f", currentCost) + "$")
    }

    func showAlert(with title: String, message: String) {
        view?.showAlert(with: title, message: message)
    }
}
