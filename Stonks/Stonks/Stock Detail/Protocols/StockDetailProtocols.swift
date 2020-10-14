import Foundation
import Charts

protocol StockDetailViewInput: class {
    func setChartData(with quotes: [ChartDataEntry])
}

protocol StockDetailViewOutput: class {
    func didLoadView()
}

protocol StockDetailRouterInput: class {

}
