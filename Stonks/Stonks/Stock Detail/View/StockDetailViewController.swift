import UIKit
import Charts

class StockDetailViewController: UIViewController {

    var output: StockDetailViewOutput?

    @IBOutlet private weak var stockDetailCardContainerView: UIView!

    @IBOutlet private weak var stockDetailCardView: CardView!

    @IBOutlet private weak var chartContainerView: UIView!

    private lazy var stockLineChartView: LineChartView = {
        let chart = LineChartView()

        chart.backgroundColor = Constants.StockLineChartView.backgoundColor
        chart.translatesAutoresizingMaskIntoConstraints = false

        chart.clipsToBounds = true
        chart.layer.cornerRadius = Constants.StockLineChartView.cornerRadius

        chart.xAxis.enabled = false
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.xAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.minOffset = Constants.StockLineChartView.minOffset
        chart.legend.enabled = false

        chart.scaleXEnabled = false
        chart.scaleYEnabled = false

        return chart
    }()

    private func addSubviews() {
        chartContainerView.addSubview(stockLineChartView)
    }

    private func setupStockChartConstraints() {
        stockLineChartView.topAnchor.constraint(equalTo: chartContainerView.topAnchor,
                                                constant: Constants.StockLineChartView.topConstraintContant).isActive = true

        stockLineChartView.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor,
                                                    constant: Constants.StockLineChartView.leadingConstraintContant).isActive = true

        stockLineChartView.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor,
                                                     constant: Constants.StockLineChartView.trailingConstraintContant).isActive = true

        stockLineChartView.bottomAnchor.constraint(equalTo: chartContainerView.bottomAnchor,
                                                   constant: Constants.StockLineChartView.bottomConstraintContant).isActive = true
    }

    private func setupConstraints() {
        setupStockChartConstraints()
    }

    private func setupStockDetailCardContainerView() {
        stockDetailCardContainerView.layer.cornerRadius = Constants.StockDetailCardContainerView.cornerRadius
        stockDetailCardContainerView.layer.shadowColor = Constants.StockDetailCardContainerView.shadowColor.cgColor
        stockDetailCardContainerView.layer.shadowOffset = Constants.StockDetailCardContainerView.shadowOffset
        stockDetailCardContainerView.layer.shadowRadius = Constants.StockDetailCardContainerView.shadowRadius
        stockDetailCardContainerView.layer.shadowOpacity = Constants.StockDetailCardContainerView.shadowOpacity
    }

    private func setupChartContainerView() {
        chartContainerView.layer.cornerRadius = Constants.ChartContainerView.cornerRadius
        chartContainerView.layer.shadowColor = Constants.ChartContainerView.shadowColor.cgColor
        chartContainerView.layer.shadowOffset = Constants.ChartContainerView.shadowOffset
        chartContainerView.layer.shadowRadius = Constants.ChartContainerView.shadowRadius
        chartContainerView.layer.shadowOpacity = Constants.ChartContainerView.shadowOpacity
    }

    private func setupStockDetailCardView() {
        stockDetailCardView.clipsToBounds = true
        stockDetailCardView.layer.cornerRadius = Constants.StockDetailCardView.cornerRadius
    }

    private func setupViews() {
        setupStockDetailCardContainerView()
        setupChartContainerView()
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

        chartDataset.circleRadius = Constants.ChartDataset.circleRadius
        chartDataset.circleColors = [NSUIColor(cgColor: Constants.chartLineColor.cgColor)]
        chartDataset.setColor(NSUIColor(cgColor: Constants.chartLineColor.cgColor))

        chartDataset.mode = .cubicBezier
        chartDataset.lineWidth = Constants.ChartDataset.lineWidth

        chartDataset.drawFilledEnabled = true
        chartDataset.fill = Fill(color: NSUIColor(cgColor: Constants.chartFillColor.cgColor))
        chartDataset.drawHorizontalHighlightIndicatorEnabled = false
        chartDataset.drawVerticalHighlightIndicatorEnabled = false

        let data = LineChartData(dataSet: chartDataset)
        data.setDrawValues(false)

        stockLineChartView.data = data
    }

    func setNavigationBarTitle(with title: String) {
        navigationItem.title = title
    }
}

extension StockDetailViewController {
    private struct Constants {
        static let chartLineColor: UIColor = UIColor(red: 113 / 255,
                                                     green: 101 / 255,
                                                     blue: 227 / 255,
                                                     alpha: 1)

        static let chartFillColor: UIColor = UIColor(red: 113 / 255,
                                                     green: 101 / 255,
                                                     blue: 227 / 255,
                                                     alpha: 0.6)

        struct ChartDataset {
            static let circleRadius: CGFloat = 3
            static let lineWidth: CGFloat = 1
        }

        struct StockDetailCardView {
            static let cornerRadius: CGFloat = 10
        }

        struct StockDetailCardContainerView {
            static let cornerRadius: CGFloat = 10
            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct ChartContainerView {
            static let cornerRadius: CGFloat = 10
            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct StockLineChartView {
            static let backgoundColor: UIColor = .white
            static let cornerRadius: CGFloat = 10
            static let minOffset: CGFloat = 0

            static let topConstraintContant: CGFloat = 50
            static let bottomConstraintContant: CGFloat = 0
            static let leadingConstraintContant: CGFloat = 0
            static let trailingConstraintContant: CGFloat = 0
        }
    }
}
