import UIKit
import PinLayout
import Charts

final class StockDetailChartView: LineChartView {
    private weak var pointInfoView: UIView!

    private weak var costLabel: UILabel!

    private var percentageX: CGFloat?

    private var percentageY: CGFloat?

    init() {
        super.init(frame: .zero)

        setupView()
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutPointInfoView()
        layoutCostLabel()
    }

    private func layoutPointInfoView() {
        guard let xPercent = percentageX,
              let yPercent = percentageY else {
            return
        }

        pointInfoView.pin
            .width(20%)
            .height(40%)

        let rootWidth = bounds.size.width
        let rootHeight = bounds.size.height
        let width = pointInfoView.bounds.size.width
        let height = pointInfoView.bounds.size.height
        var topOffset: CGFloat = yPercent * bounds.size.height - height / 2
        var leftOffset: CGFloat = xPercent * bounds.size.width - width / 2

        if topOffset <= .zero {
            topOffset = 1
        }

        if topOffset + height >= rootHeight {
            topOffset = rootHeight - height - 1
        }

        if leftOffset <= .zero {
            leftOffset = 1
        }

        if leftOffset + width >= rootWidth {
            leftOffset = rootWidth - width - 1
        }

        pointInfoView.pin
            .top(topOffset)
            .left(leftOffset)
    }

    private func layoutCostLabel() {
        costLabel.pin
            .hCenter()
            .vCenter()
            .width(Constants.CostLabel.widthPercent)
            .height(Constants.CostLabel.heightPercent)
    }

    private func setupView() {

    }

    private func setupSubviews() {
        setupPointInfoView()
        setupCostLabel()
    }

    private func setupPointInfoView() {
        let pointView = UIView()

        pointInfoView = pointView
        addSubview(pointInfoView)

        pointInfoView.backgroundColor = UIColor(red: 113 / 255,
                                                green: 101 / 255,
                                                blue: 227 / 255,
                                                alpha: 0.8)
        pointInfoView.layer.cornerRadius = 15
        pointInfoView.isUserInteractionEnabled = false
    }

    private func setupCostLabel() {
        let label = UILabel()

        costLabel = label
        pointInfoView.addSubview(costLabel)

        costLabel.textAlignment = .center
        costLabel.font = Constants.CostLabel.font
    }
}

extension StockDetailChartView: StockDetailChartViewInput {
    func configure(text: String, percentageX: CGFloat, percentageY: CGFloat) {
        self.percentageX = percentageX
        self.percentageY = percentageY

        layoutSubviews()

        pointInfoView.alpha = 1
        UIView.animate(withDuration: 2.5) {
            self.pointInfoView.alpha = 0
        }

        costLabel.text = text
    }
}

extension StockDetailChartView {
    private struct Constants {
        struct CostLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 16)

            static let widthPercent: Percent = 100%
            static let heightPercent: Percent = 100%
        }
    }
}
