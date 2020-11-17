import UIKit
import Charts

final class MePortfolioPresenter {
    weak var view: MePortfolioInput?
    var router: MePortfolioRouterInput?
    private var interactor: MePortfolioInteractorInput
    private var stocks: [MePortfolioStockData] = [] {
        didSet {
            setNumbersInChart(number: stocks.count)
        }
    }
    private var numberOfStocksInChart: Int = 0

    required init(interactor: MePortfolioInteractorInput) {
        self.interactor = interactor
    }

    private func setNumbersInChart(number: Int) {
        if number < Constants.maxStocksInChart {
            numberOfStocksInChart = number
        } else {
            numberOfStocksInChart = Constants.maxStocksInChart
        }
    }

    // MARK: PieChartData prepare
    private func countStocks() -> [(String, Float)] {
        var stocksWithPrices: [String: Float] = [:]
        for stock in stocks {
            stocksWithPrices[stock.stockSymbol] = Float(stock.amount) * stock.currentPrice
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
        interactor.loadStocks()
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

extension MePortfolioPresenter: MePortfolioInteractorOutput {
    func didLoaded(stocks: [MePortfolioStockData]) {
        self.stocks = stocks
    }
}
