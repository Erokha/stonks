import Foundation
import Charts

protocol MePortfolioInput: class {
    func drawDiagramm(pieChartData: PieChartData)
    func noDataMessage(message: String)
}

protocol MePortfolioOutput: class {
    func createChartData()
    func didLoadView()
}

protocol MePortfolioRouterInput: class {
    // some viewControllers to go
}
