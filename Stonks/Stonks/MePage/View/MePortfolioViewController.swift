import UIKit
import Charts


class MePortfolioViewController: UIViewController, MePortfolioInput {
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
    
    @IBAction func historyButtonAcrtion(_ sender: UIButton) {
    }
}

extension MePortfolioViewController {
    func configureUi() {
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
}
