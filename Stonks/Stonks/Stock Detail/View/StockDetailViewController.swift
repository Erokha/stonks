import UIKit
import Charts

class StockDetailViewController: UIViewController {

    var output: StockDetailViewOutput?

    @IBOutlet private weak var stockDetailCardContainerView: UIView!

    @IBOutlet private weak var stockDetailCardView: CardView!

    @IBOutlet private weak var chartView: UIView!

    let chartLineColor: UIColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 1)
    let chartFillColor: UIColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 0.6)

    private lazy var stockChart: LineChartView = {
        let chart = LineChartView()

        chart.backgroundColor = .white
        chart.translatesAutoresizingMaskIntoConstraints = false

        chart.clipsToBounds = true
        chart.layer.cornerRadius = 10

        chart.xAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.minOffset = 0
        chart.legend.enabled = false

        chart.scaleXEnabled = false
        chart.scaleYEnabled = false

        return chart
    }()

    private func addSubviews() {
        chartView.addSubview(stockChart)
    }

    private func setupStockChartViewConstraints() {
        stockChart.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 50).isActive = true
        stockChart.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 0).isActive = true
        stockChart.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 0).isActive = true
        stockChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 0).isActive = true
    }

    private func setupConstraints() {
        setupStockChartViewConstraints()
    }

    private func setupStockDetailCardContainerView() {
        stockDetailCardContainerView.layer.cornerRadius = 10
        stockDetailCardContainerView.layer.shadowColor = UIColor.black.cgColor
        stockDetailCardContainerView.layer.shadowOffset = CGSize(width: 0, height: 3)
        stockDetailCardContainerView.layer.shadowRadius = 3
        stockDetailCardContainerView.layer.shadowOpacity = 0.5
    }

    private func setupChartView() {
        chartView.layer.cornerRadius = 10
        chartView.layer.shadowColor = UIColor.black.cgColor
        chartView.layer.shadowOffset = CGSize(width: 0, height: 3)
        chartView.layer.shadowRadius = 3
        chartView.layer.shadowOpacity = 0.5
    }

    private func setupStockDetailCardView() {
        stockDetailCardView.clipsToBounds = true
        stockDetailCardView.layer.cornerRadius = 10
    }

    private func setupViews() {
        setupStockDetailCardContainerView()
        setupChartView()
        setupStockDetailCardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setupViews()
        setupConstraints()

        output?.didLoadView()
    }
}

extension StockDetailViewController: StockDetailViewInput {
    func setChartData(with quotes: [ChartDataEntry]) {
        let chartDataset = LineChartDataSet(quotes)

        chartDataset.circleRadius = 3
        chartDataset.circleColors = [NSUIColor(cgColor: chartLineColor.cgColor)]
        chartDataset.setColor(NSUIColor(cgColor: chartLineColor.cgColor))

        chartDataset.mode = .cubicBezier
        chartDataset.lineWidth = 1

        chartDataset.drawFilledEnabled = true
        chartDataset.fill = Fill(color: NSUIColor(cgColor: chartFillColor.cgColor))
        chartDataset.drawHorizontalHighlightIndicatorEnabled = false
        chartDataset.drawVerticalHighlightIndicatorEnabled = false

        let data = LineChartData(dataSet: chartDataset)
        data.setDrawValues(false)

        stockChart.data = data
    }
}
