import UIKit
import Charts

class MePortfolioPresenter {
    weak var view: MePortfolioInput?
    var router: MePortfolioRouterInput?
    private var stocks: [Stock] = []
    private var numberOfStocksInChart: Int = 0
    
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
        static let noDataMessage = "You don't have any stocks:("
    }
}

extension MePortfolioPresenter: MePortfolioOutput {
    func noDataMessage() -> String {
        return MePortfolioPresenter.Constants.noDataMessage
    }
    
    func didLoadView() {
        //TODO: loading stocks from Core Data
//        let stock1 = Stock(stockSymbol: "AAPL", stockprice: 2000, numOfStocks: 2)
//        let stock2 = Stock(stockSymbol: "ABC", stockprice: 300, numOfStocks: 4)
//        let stock3 = Stock(stockSymbol: "GGL", stockprice: 1000, numOfStocks: 1)
//        let stock4 = Stock(stockSymbol: "LENOVO", stockprice: 2000, numOfStocks: 4)
//        self.stocks.append(stock1)
//        self.stocks.append(stock2)
//        self.stocks.append(stock3)
//        self.stocks.append(stock4)
//        setNumbersInChart(number: stocks.count)
    }
    
    func createChartData() -> PieChartData? {
        let dataEntries = createDataEntry()
        if dataEntries.count > 0 {
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

