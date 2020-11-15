import UIKit
import Charts

class MePortfolioPresenter {
    weak var view: MePortfolioInput?
    var router: MePortfolioRouterInput?

    private var stocks: [StockData] = [] {
        didSet {
            setNumbersInChart(number: stocks.count)
        }
    }
    private var numberOfStocksInChart: Int = 0

    required init() {
    }

    private func setNumbersInChart(number: Int) {
        guard number < MePortfolioPresenter.Constants.maxStocksInChart  else { return }
        numberOfStocksInChart = number
    }

    // MARK: PieChartData prepare
    private func countStocks() -> [(String, Float)] {
        var stocksWithPrices: [String: Float] = [:]
        for stock in stocks {
            stocksWithPrices[stock.stockSymbol] = Float(stock.stockCount) * stock.stockPrice
        }
        let sortedStocksByPrice = stocksWithPrices.sorted { (first: (key: String, value: Float), second: (key: String, value: Float)) -> Bool in
            return first.value > second.value
        }
        return sortedStocksByPrice
    }

    private func createDataEntry() -> [PieChartDataEntry] {
        let stocksWithValues = countStocks()
        var chartStocks: [PieChartDataEntry] = []
        for i in 0..<numberOfStocksInChart {
            let chartValue = stocksWithValues[i].1
            let chartLabel = stocksWithValues[i].0
            chartStocks.append(PieChartDataEntry(value: Double(chartValue), label: chartLabel))
        }
        return chartStocks
    }

    private func generateColors(numberOfColors: Int) -> [NSUIColor] {
        let totalColors: [NSUIColor] = Array(MePortfolioPresenter.Constants.chartColors.prefix( numberOfStocksInChart))
        return totalColors
    }
}

extension MePortfolioPresenter {
    private struct Constants {
        static let chartColors: [NSUIColor] = ChartColors.allCases.map { NSUIColor(hex: $0.rawValue) }
        static let maxStocksInChart = 5
        static let noDataMessage = "You don't have any stocks:("
    }
}

extension MePortfolioPresenter: MePortfolioOutput {
    func didHistoryButtonTapped() {
        router?.showHistory()
    }

    func noDataMessage() -> String {
        return MePortfolioPresenter.Constants.noDataMessage
    }

    func didLoadView() {
        // Here we will load data from User Defaults

    }

    func createChartData() -> PieChartData? {
        let dataEntries = createDataEntry()
        if !dataEntries.isEmpty {
            let colors = generateColors(numberOfColors: dataEntries.count)
            let dataSet = PieChartDataSet(entries: dataEntries, label: "")
            dataSet.colors = colors
            let pieChartData = PieChartData(dataSet: dataSet)
            return pieChartData
        } else {
            return nil
        }
    }
}
