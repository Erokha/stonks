import Foundation
import Charts

extension MePortfolioViewController {
    func chartSettings() {
        
        self.stocksPieChartView.chartDescription?.enabled = false
        self.stocksPieChartView.drawHoleEnabled = false
        self.stocksPieChartView.rotationAngle = 0
        self.stocksPieChartView.isUserInteractionEnabled = false
        self.stocksPieChartView.drawEntryLabelsEnabled = false
        self.stocksPieChartView.legend.formSize = 15
        self.stocksPieChartView.legend.form = .circle
        self.stocksPieChartView.legend.horizontalAlignment = .center
    }
    
    func drawDiagramm(pieChartData: PieChartData) {
        self.stocksPieChartView.data = pieChartData
    }
}


extension NSUIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
