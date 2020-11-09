import Foundation
import Charts

protocol MePortfolioInput: class {

}

protocol MePortfolioOutput: class {
    func createChartData() -> PieChartData?
    func didLoadView()
    func noDataMessage() -> String
    func didHistoryButtonTapped()
}

protocol MePortfolioRouterInput: class {
    func showHistory()
}
