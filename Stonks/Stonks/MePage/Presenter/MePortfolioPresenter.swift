import UIKit
import Charts

class MePortfolioPresenter: MePortfolioOutput {
    
    unowned let view: MePortfolioViewController
    var stocks: [Stock] = []
    var totalSpent: Double = 0
    var chartDataSet: PieChartDataSet?
    let maxStocksInChart = 5
    var numberOfStocksInChart: Int = 5
    let chartColors:[NSUIColor] = ChartColors.allCases.map{ NSUIColor(hex: $0.rawValue) }
    
    required init(view: MePortfolioViewController, stocks: [Stock], totalSpent: Double) {
        self.view = view
        self.stocks = stocks
        setNumbersInChart(number: stocks.count)
        self.totalSpent = totalSpent
    }
    
    private func setNumbersInChart(number: Int) {
        if number < self.maxStocksInChart {
            self.numberOfStocksInChart = number
        }
    }
    
    // MARK: PieChartData prepare
    func createChartData() {
        let dataEntries = createDataEntry()
        let colors = generateColors(numberOfColors: dataEntries.count)
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = colors
        let pieChartData = PieChartData(dataSet: dataSet)
        self.view.drawDiagramm(pieChartData: pieChartData)
    }
    
    internal func countStocks() -> [(String, Float)] {
        var stocksWithPrices: [String: Float] = [:]
        for stock in stocks {
            stocksWithPrices[stock.stockSymbol] = Float(stock.numOfStocks) * stock.stockprice
        }
        let sortedDictinary = stocksWithPrices.sorted { (first: (key: String, value: Float), second: (key: String, value: Float)) -> Bool in
            return first.value > second.value
        }
        return sortedDictinary
    }
    
    internal func createDataEntry() -> [PieChartDataEntry] {
        let stocksWithValues = countStocks()
        var chartStocks: [PieChartDataEntry] = []
        for i in 0..<numberOfStocksInChart {
            let chartValue = stocksWithValues[i].1
            let chartLabel = stocksWithValues[i].0
            chartStocks.append(PieChartDataEntry(value: Double(chartValue), label: chartLabel))
        }
        return chartStocks
    }
    
    internal func generateColors(numberOfColors: Int) -> [NSUIColor] {
        let totalColors: [NSUIColor] = Array(chartColors.prefix( self.numberOfStocksInChart))
        return totalColors
    }
}
