import Foundation
import Charts

class StockDetailPresenter {

    weak var view: StockDetailViewInput?
    var router: StockDetailRouterInput?
    var interactor: StockDetailInteractorInput?

    private var model: StockDetailData

    init(model: StockDetailData) {
        self.model = model
    }
}

extension StockDetailPresenter: StockDetailViewOutput {
    func didLoadView() {
        guard let stockName = model.name else {
            return
        }

        interactor?.fetchStockQuotes(for: stockName)
    }

    func didTapBuyButton(amount: String?) {
        guard let amountString = amount,
              !amountString.isEmpty else {
            view?.showAlert(with: "Ошибка", message: "Не введено количество акций")
            return
        }

        guard let amount = Int(amountString) else {
            view?.showAlert(with: "Ошибка", message: "Невозможно преобразовать количество в число")
            return
        }

        print(amount)
    }

    func didTapSellButton(amount: String?) {
        guard let amountString = amount,
              !amountString.isEmpty else {
            view?.showAlert(with: "Ошибка", message: "Не введено количество акций")
            return
        }

        guard let amount = Int(amountString) else {
            view?.showAlert(with: "Ошибка", message: "Невозможно преобразовать количество в число")
            return
        }

        print(amount)
    }
}

extension StockDetailPresenter: StockDetailInteractorOutput {
    func freshCostDidReceived(cost: Double) {
        model.quotes?.removeFirst()
        model.quotes?.append((20, cost))

        guard let chartData = model.quotes?.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        }) else {
            return
        }

        view?.setChartData(with: chartData)
        view?.setStockCurrentCostLabel(with: String(format: "%.1f", cost) + "$")
    }

    func stockQuotesDidReceived(quotes: [(Double, Double)]?) {
        model.quotes = quotes

        guard let chartData = model.quotes?.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        }) else {
            print("Data not fetched")
            return
        }

        guard let stockName = model.name else {
            return
        }

        guard let currentCost = chartData.last?.y else {
            return
        }

        view?.setChartData(with: chartData)
        view?.setNavigationBarTitle(with: stockName)
        view?.setStockNameLabel(with: stockName)
        view?.setStockCurrentCostLabel(with: String(format: "%.1f", currentCost) + "$")
    }
}
