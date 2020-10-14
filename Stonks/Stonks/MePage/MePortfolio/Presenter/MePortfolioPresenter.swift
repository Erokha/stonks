import UIKit
import Charts

class MePortfolioPresenter {
    weak var view: MePortfolioInput?
    private var stocks: [Stock] = []
    private var numberOfStocksInChart: Int = 0
    var router: MePortfolioRouterInput?
    
    required init() {
    }
    
    private func setNumbersInChart(number: Int) {
        if number < MePortfolioPresenter.Constants.maxStocksInChart {
            self.numberOfStocksInChart = number
        }
    }
    
    // MARK: PieChartData prepare
    private func countStocks() -> [(String, Float)] {
        var stocksWithPrices: [String: Float] = [:]
        for stock in stocks {
            stocksWithPrices[stock.stockSymbol] = Float(stock.numOfStocks) * stock.stockprice
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
        static let chartColors: [NSUIColor] = ChartColors.allCases.map{ NSUIColor(hex: $0.rawValue) }
        static let maxStocksInChart = 5
    }
}

extension MePortfolioPresenter: MePortfolioOutput {
    func didLoadView() {
        //TODO: loading stocks from Core Data
    }
    
    func createChartData() {
        let dataEntries = createDataEntry()
        if dataEntries.count > 0 {
            let colors = generateColors(numberOfColors: dataEntries.count)
            let dataSet = PieChartDataSet(entries: dataEntries, label: "")
            dataSet.colors = colors
            let pieChartData = PieChartData(dataSet: dataSet)
            self.view?.drawDiagramm(pieChartData: pieChartData)
        } else {
            self.view?.noDataMessage(message: "You don't have any stocks:(")
        }
    }
}

