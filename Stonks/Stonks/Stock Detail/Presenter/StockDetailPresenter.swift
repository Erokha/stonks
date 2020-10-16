import Foundation
import Charts

class StockDetailPresenter {

    weak var view: StockDetailViewInput?
    var router: StockDetailRouterInput?

    private var model: StockDetailData

    init(model: StockDetailData) {
        self.model = model
    }

    private func fetchData() -> [(Double, Double)] {
        var dataset: [(Double, Double)] = []

        for i in 0..<20 {
            let value = Double.random(in: 0.0 ... 50.0)
            dataset.append((Double(i), value))
        }

        return dataset
    }
}

extension StockDetailPresenter: StockDetailViewOutput {
    func didLoadView() {
        model.quotes = fetchData()

        guard let chartData = model.quotes?.map({(tuple: (Double, Double)) -> ChartDataEntry in
            return ChartDataEntry(x: tuple.0, y: tuple.1)
        }) else {
            print("Data not fetched")
            return
        }

        view?.setChartData(with: chartData)

        guard let stockName = model.name else {
            return
        }

        view?.setNavigationBarTitle(with: stockName)
    }
}
