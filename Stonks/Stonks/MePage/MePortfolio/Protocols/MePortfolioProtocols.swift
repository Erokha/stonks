import Foundation
import Charts

protocol MePortfolioInput: class {

}

protocol MePortfolioOutput: class {
    func createChartData() -> PieChartData?
    func didLoadView()
    func noDataMessage() -> String
}

protocol MePortfolioRouterInput: class {
    // some viewControllers to go
}
