import UIKit
import Charts

class StockDetailViewController: UIViewController {

    var output: StockDetailViewOutput?

    @IBOutlet private weak var stockDetailCardContainerView: UIView!

    @IBOutlet private weak var stockDetailCardView: CardView!

    @IBOutlet private weak var chartContainerView: UIView!

    @IBOutlet private weak var buyButton: UIButton!

    @IBOutlet private weak var sellButton: UIButton!

    @IBOutlet private weak var buyTextFieldContainerView: UIView!

    @IBOutlet private weak var sellTextFieldContainerView: UIView!

    @IBOutlet private weak var buyTextField: UITextField!

    @IBOutlet private weak var sellTextField: UITextField!

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

    private func setupBuyButton() {
        buyButton.backgroundColor = Constants.BuyButton.backgroundColor
        buyButton.titleLabel?.font = Constants.BuyButton.font
        buyButton.setTitleColor(Constants.BuyButton.textColor, for: .normal)
        buyButton.layer.cornerRadius = Constants.BuyButton.cornerRadius

        buyButton.layer.shadowColor = Constants.BuyButton.shadowColor.cgColor
        buyButton.layer.shadowOffset = Constants.BuyButton.shadowOffset
        buyButton.layer.shadowRadius = Constants.BuyButton.shadowRadius
        buyButton.layer.shadowOpacity = Constants.BuyButton.shadowOpacity
    }

    private func setupSellButton() {
        sellButton.backgroundColor = Constants.SellButton.backgroundColor
        sellButton.titleLabel?.font = Constants.SellButton.font
        sellButton.setTitleColor(Constants.SellButton.textColor, for: .normal)
        sellButton.layer.cornerRadius = Constants.SellButton.cornerRadius

        sellButton.layer.shadowColor = Constants.SellButton.shadowColor.cgColor
        sellButton.layer.shadowOffset = Constants.SellButton.shadowOffset
        sellButton.layer.shadowRadius = Constants.SellButton.shadowRadius
        sellButton.layer.shadowOpacity = Constants.SellButton.shadowOpacity
    }

    private func setupBuyTextField() {
        buyTextField.clipsToBounds = true
        buyTextField.layer.cornerRadius = Constants.BuyTextField.cornerRadius
        buyTextField.layer.borderWidth = Constants.BuyTextField.borderWidth
        buyTextField.backgroundColor = Constants.BuyTextField.backgroundColor
        buyTextField.layer.borderColor = Constants.BuyTextField.borderColor.cgColor

        buyTextField.attributedPlaceholder = NSAttributedString(string: Constants.BuyTextField.placeholderText,
                                                                attributes: [NSAttributedString.Key.foregroundColor: Constants.BuyTextField.placeholderColor])
    }

    private func setupBuyTextFieldContainerView() {
        buyTextFieldContainerView.layer.cornerRadius = Constants.BuyTextField.cornerRadius

        buyTextFieldContainerView.layer.shadowColor = Constants.BuyTextField.shadowColor.cgColor
        buyTextFieldContainerView.layer.shadowOffset = Constants.BuyTextField.shadowOffset
        buyTextFieldContainerView.layer.shadowRadius = Constants.BuyTextField.shadowRadius
        buyTextFieldContainerView.layer.shadowOpacity = Constants.BuyTextField.shadowOpacity
    }

    private func setupSellTextField() {
        sellTextField.clipsToBounds = true
        sellTextField.layer.cornerRadius = Constants.SellTextField.cornerRadius
        sellTextField.layer.borderWidth = Constants.SellTextField.borderWidth
        sellTextField.backgroundColor = Constants.SellTextField.backgroundColor
        sellTextField.layer.borderColor = Constants.SellTextField.borderColor.cgColor

        sellTextField.attributedPlaceholder = NSAttributedString(string: Constants.SellTextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.SellTextField.placeholderColor])
    }

    private func setupSellTextFieldContainerView() {
        sellTextFieldContainerView.layer.cornerRadius = Constants.SellTextField.cornerRadius

        sellTextFieldContainerView.layer.shadowColor = Constants.SellTextField.shadowColor.cgColor
        sellTextFieldContainerView.layer.shadowOffset = Constants.SellTextField.shadowOffset
        sellTextFieldContainerView.layer.shadowRadius = Constants.SellTextField.shadowRadius
        sellTextFieldContainerView.layer.shadowOpacity = Constants.SellTextField.shadowOpacity
    }

    private func setupViews() {
        setupStockDetailCardContainerView()
        setupChartContainerView()
        setupStockDetailCardView()
        setupBuyButton()
        setupSellButton()
        setupBuyTextField()
        setupBuyTextFieldContainerView()
        setupSellTextField()
        setupSellTextFieldContainerView()
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

        struct BuyButton {
            static let backgroundColor: UIColor = UIColor(red: 71 / 255,
                                                          green: 190 / 255,
                                                          blue: 162 / 255,
                                                          alpha: 1)

            static let font = UIFont(name: "DMSans-Bold", size: 17)
            static let textColor: UIColor = .white
            static let cornerRadius: CGFloat = 10

            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct SellButton {
            static let backgroundColor: UIColor = UIColor(red: 255 / 255,
                                                          green: 199 / 255,
                                                          blue: 91 / 255,
                                                          alpha: 1)

            static let font = UIFont(name: "DMSans-Bold", size: 17)
            static let textColor: UIColor = .white
            static let cornerRadius: CGFloat = 10

            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct BuyTextField {
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
            static let backgroundColor: UIColor = .white
            static let borderColor: UIColor = .white

            static let placeholderText: String = "Amount"
            static let placeholderTextColor: UIColor = .black

            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct SellTextField {
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
            static let backgroundColor: UIColor = .white
            static let borderColor: UIColor = .white

            static let placeholderText: String = "Amount"
            static let placeholderTextColor: UIColor = .black

            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }
    }
}
