import UIKit
import Charts

final class ChartTableViewCell: UITableViewCell {
    @IBOutlet private weak var stocksPieChartView: PieChartView!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var mainChartView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMainView()
        setupChartView()
        chartViewSettings()
        setupCell()
    }

    private func setupCell() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    private func setupMainView() {
        mainChartView.layer.cornerRadius = ChartTableViewCell.Constants.viewRadius
        mainChartView.layer.shadowColor = UIColor.gray.cgColor
        mainChartView.layer.shadowRadius = ChartTableViewCell.Constants.shadowRadius
        mainChartView.layer.shadowOffset = .init(width: 0, height: 3)
        mainChartView.layer.shadowOpacity = ChartTableViewCell.Constants.shadowOpacity
    }

    private func setupChartView() {
        noDataLabel.text = ""
        stocksPieChartView.layer.cornerRadius = ChartTableViewCell.Constants.viewRadius
        stocksPieChartView.layer.shadowColor = UIColor.gray.cgColor
        stocksPieChartView.layer.shadowRadius = ChartTableViewCell.Constants.shadowRadius
        stocksPieChartView.layer.shadowOffset = .init(width: 0, height: 3)
        stocksPieChartView.layer.shadowOpacity = ChartTableViewCell.Constants.shadowOpacity
    }

    private func chartViewSettings() {
        stocksPieChartView.chartDescription?.enabled = false
        stocksPieChartView.rotationAngle = 0
        stocksPieChartView.rotationEnabled = false
        stocksPieChartView.drawHoleEnabled = false
        stocksPieChartView.isUserInteractionEnabled = false
        stocksPieChartView.drawEntryLabelsEnabled = false
        stocksPieChartView.legend.formSize = ChartTableViewCell.Constants.legendFormSize
        stocksPieChartView.legend.form = .circle
        stocksPieChartView.legend.horizontalAlignment = .center
        stocksPieChartView.noDataText = ""
    }

    private func setDataFormatter(pieChartData: PieChartData) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.zeroSymbol = ""
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
    }

    func configureChartView(pieChartData: PieChartData) {
        setDataFormatter(pieChartData: pieChartData)
        self.stocksPieChartView.data = pieChartData
    }

    func noDataMessage(message: String) {
        self.noDataLabel.text = message
    }
}

extension ChartTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 3
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
    }
}
