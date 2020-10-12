import Foundation
import Charts

protocol MePortfolioInput {
    func drawDiagramm(pieChartData: PieChartData)
}

protocol MePortfolioOutput {
    func createChartData()
}

