import UIKit
import Charts

class StockDetailViewController: UIViewController, StockDetailViewType {

    var output: StockDetailViewOutput?

    @IBOutlet private weak var stockDetailCard: UIView!
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

    private func setupConstraints() {
        stockChart.topAnchor.constraint(equalTo: chartView.topAnchor, constant: 50).isActive = true
        stockChart.leadingAnchor.constraint(equalTo: chartView.leadingAnchor, constant: 0).isActive = true
        stockChart.trailingAnchor.constraint(equalTo: chartView.trailingAnchor, constant: 0).isActive = true
        stockChart.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 0).isActive = true
    }

    private func setupViews() {
        stockDetailCard.layer.cornerRadius = 10

        stockDetailCard.layer.shadowColor = UIColor.black.cgColor
        stockDetailCard.layer.shadowOffset = CGSize(width: 0, height: 3)
        stockDetailCard.layer.shadowRadius = 3
        stockDetailCard.layer.shadowOpacity = 0.5

        chartView.layer.cornerRadius = 10
        chartView.layer.shadowColor = UIColor.black.cgColor
        chartView.layer.shadowOffset = CGSize(width: 0, height: 3)
        chartView.layer.shadowRadius = 3
        chartView.layer.shadowOpacity = 0.5
    }

    private func transformDataset(dataset: [(Date, Double)]) -> [ChartDataEntry] {
        var result: [ChartDataEntry] = []
        let calendar = Calendar.current

        for i in 0..<dataset.count {
            result.append(ChartDataEntry(x: Double(calendar.component(.minute, from: dataset[i].0)), y: dataset[i].1))
        }

        return result
    }

    private func refreshChartData() {
        /*
        let dataset: [(Date, Double)] = output?.fetchData()
        
        let chartAdaptiveDataset: [ChartDataEntry] = transformDataset(dataset: dataset)
        
        let chartDataset = LineChartDataSet(chartAdaptiveDataset)
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
         */
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews() // заглушка

        addSubviews()
        setupConstraints()

        refreshChartData()
    }
}

extension StockDetailViewController: StockDetailViewInput {

}
