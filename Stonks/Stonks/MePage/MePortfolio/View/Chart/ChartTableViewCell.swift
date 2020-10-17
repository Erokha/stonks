import UIKit
import Charts

class ChartTableViewCell: UITableViewCell {
    @IBOutlet private weak var stocksPieChartView: PieChartView!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var mainChartView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainView()
        setupChartView()
        chartViewSettings()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    private func setupMainView() {
        mainChartView.layer.cornerRadius = CGFloat(ChartTableViewCell.Constants.viewRadius)
        mainChartView.layer.shadowColor = UIColor.black.cgColor
        mainChartView.layer.shadowRadius = CGFloat(ChartTableViewCell.Constants.shadowRadius)
        mainChartView.layer.shadowOffset = .zero
        mainChartView.layer.shadowOpacity = Float(ChartTableViewCell.Constants.shadowOpacity)
    }

    private func setupChartView() {
        noDataLabel.text = ""
        stocksPieChartView.layer.cornerRadius = CGFloat(ChartTableViewCell.Constants.viewRadius)
        stocksPieChartView.layer.shadowColor = UIColor.black.cgColor
        stocksPieChartView.layer.shadowRadius = CGFloat(ChartTableViewCell.Constants.shadowRadius)
        stocksPieChartView.layer.shadowOffset = .zero
        stocksPieChartView.layer.shadowOpacity = Float(ChartTableViewCell.Constants.shadowOpacity)
        stocksPieChartView.layer.shadowOffset = .zero
    }

    private func chartViewSettings() {
        stocksPieChartView.chartDescription?.enabled = false
        stocksPieChartView.drawHoleEnabled = false
        stocksPieChartView.isUserInteractionEnabled = false
        stocksPieChartView.drawEntryLabelsEnabled = false
        stocksPieChartView.legend.formSize = CGFloat(ChartTableViewCell.Constants.legendFormSize)
        stocksPieChartView.legend.form = .circle
        stocksPieChartView.legend.horizontalAlignment = .center
        stocksPieChartView.noDataText = ""
    }

    func configureChartView(pieChartData: PieChartData) {
        self.stocksPieChartView.data = pieChartData
    }

    func noDataMessage(message: String) {
        self.noDataLabel.text = message
    }
}

extension ChartTableViewCell {
    private struct Constants {
        static let viewRadius = 15
        static let shadowRadius = 5
        static let shadowOpacity = 0.6
        static let legendFormSize = 15
    }
}
