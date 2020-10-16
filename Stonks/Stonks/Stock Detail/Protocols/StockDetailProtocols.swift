import Foundation
import Charts

protocol StockDetailViewInput: class {
    func setChartData(with quotes: [ChartDataEntry])
    func setNavigationBarTitle(with titel: String)
}

protocol StockDetailViewOutput: class {
    func didLoadView()
}

protocol StockDetailRouterInput: class {

}
