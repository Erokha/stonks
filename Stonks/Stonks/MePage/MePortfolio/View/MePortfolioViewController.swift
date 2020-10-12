import UIKit
import Charts


class MePortfolioViewController: UIViewController {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var stocksPieChartView: PieChartView!
    @IBOutlet weak var historyButton: UIButton!
    
    var presenter: MePortfolioOutput!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartSettings()
        configureUi()
        presenter.createChartData()
    }
    
    private func configureUi() {
        self.chartView.layer.cornerRadius = 15
        chartView.layer.shadowColor = UIColor.black.cgColor
        self.chartView.layer.shadowRadius = 5
        self.chartView.layer.shadowOffset = .zero
        self.chartView.layer.shadowOpacity = 0.6
        self.historyButton.layer.cornerRadius = 15
        self.historyButton.layer.shadowRadius = 5
        self.historyButton.layer.shadowOffset = .zero
        self.historyButton.layer.shadowOpacity = 0.6
    }
    
    private func chartSettings() {
        self.stocksPieChartView.chartDescription?.enabled = false
        self.stocksPieChartView.drawHoleEnabled = false
        self.stocksPieChartView.rotationAngle = 0
        self.stocksPieChartView.isUserInteractionEnabled = false
        self.stocksPieChartView.drawEntryLabelsEnabled = false
        self.stocksPieChartView.legend.formSize = 15
        self.stocksPieChartView.legend.form = .circle
        self.stocksPieChartView.legend.horizontalAlignment = .center
    }
    
    
    @IBAction func didHistoryButtonTapped(_ sender: UIButton) {
        print("Hello")
    }
}


extension MePortfolioViewController: MePortfolioInput {
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
