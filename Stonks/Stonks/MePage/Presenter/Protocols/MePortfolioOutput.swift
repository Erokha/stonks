import Foundation
import Charts

protocol MePortfolioOutput {
    func countStocks() -> [(String, Float)]
    func createDataEntry() -> [PieChartDataEntry]
    func generateColors(numberOfColors: Int) -> [NSUIColor]
    func createChartData()
}

