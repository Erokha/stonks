import UIKit
import Charts

final class ChartTableViewCell: UITableViewCell {
    static let identifier = "chartTableCell"

    private let stocksPieChartView: PieChartView = {
        let chartView = PieChartView()
        return chartView
    }()

    private let noDataLabel: UILabel = {
        let noDataLabel = UILabel()
        noDataLabel.font = UIFont(name: "DMSans-Bold", size: 16)
        noDataLabel.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        noDataLabel.textAlignment = .center
        return noDataLabel
    }()

    private let mainChartView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
    }()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DMSans-Bold", size: 16)
        label.textColor = #colorLiteral(red: 0.1960784314, green: 0.2549019608, blue: 0.2823529412, alpha: 1)
        label.text = "Statistic"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkTheme()
        setupMainView()
        setupChartView()
        chartViewSettings()
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupMainChartView()
        setupHeaderLabel()
        setupPieChart()
        setupActivityIndicator()
        setupNoDataLabel()
    }

    private func setupMainChartView() {
        mainChartView.pin
            .left(35)
            .right(35)
            .top(20)
            .bottom(20)
    }

    private func setupHeaderLabel() {
        mainChartView.addSubview(headerLabel)
        headerLabel.pin
            .top(8)
            .left(10)
            .width(100)
            .sizeToFit(.width)
    }

    private func setupPieChart() {
        mainChartView.addSubview(stocksPieChartView)
        stocksPieChartView.pin
            .top(20)
            .left(5)
            .right(5)
            .bottom(5)
    }

    private func setupActivityIndicator() {
        mainChartView.addSubview(activityIndicator)
        activityIndicator.pin
            .center()
    }

    private func setupNoDataLabel() {
        mainChartView.addSubview(noDataLabel)
        noDataLabel.pin
            .center()
            .width(300)
            .sizeToFit(.width)
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            contentView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            mainChartView.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            mainChartView.layer.shadowColor = UIColor.black.cgColor
            headerLabel.textColor = .white
        } else {
            contentView.backgroundColor = .white
            mainChartView.layer.shadowColor = UIColor.gray.cgColor
            mainChartView.backgroundColor = .white
        }
    }

    private func setupCell() {
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.addSubview(mainChartView)
    }

    private func setupMainView() {
        activityIndicator.hidesWhenStopped = true
        mainChartView.layer.cornerRadius = Constants.viewRadius
        mainChartView.layer.shadowRadius = Constants.shadowRadius
        mainChartView.layer.shadowOffset = .init(width: 0, height: 3)
        mainChartView.layer.shadowOpacity = Constants.shadowOpacity
    }

    private func setupChartView() {
        noDataLabel.text = ""
        stocksPieChartView.layer.cornerRadius = Constants.viewRadius
        stocksPieChartView.layer.shadowRadius = Constants.shadowRadius
        stocksPieChartView.layer.shadowOffset = .init(width: 0, height: 3)
        stocksPieChartView.layer.shadowOpacity = Constants.shadowOpacity
    }

    private func chartViewSettings() {
        stocksPieChartView.chartDescription?.enabled = false
        stocksPieChartView.rotationAngle = 0
        stocksPieChartView.rotationEnabled = false
        stocksPieChartView.drawHoleEnabled = false
        stocksPieChartView.isUserInteractionEnabled = false
        stocksPieChartView.drawEntryLabelsEnabled = false
        stocksPieChartView.legend.formSize = Constants.legendFormSize
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
        activityIndicator.stopAnimating()
        if pieChartData.entryCount == 0 {
            self.noDataLabel.text = Constants.noDataMessage
        } else {
            self.noDataLabel.text = ""
        }
        setDataFormatter(pieChartData: pieChartData)
        self.stocksPieChartView.data = pieChartData
    }

    func dataIsNotAvaliable() {
        self.stocksPieChartView.data = nil
        self.activityIndicator.startAnimating()
    }
}

extension ChartTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 3
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
        static let noDataMessage: String = "You don't have any stocks:("
    }
}
