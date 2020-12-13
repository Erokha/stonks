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
            .width(Constants.PointInfoView.widthPercent)
            .height(pointInfoView.bounds.size.width)

        let rootWidth = bounds.size.width
        let rootHeight = bounds.size.height
        let width = pointInfoView.bounds.size.width
        let height = pointInfoView.bounds.size.height
        var topOffset: CGFloat = yPercent * bounds.size.height - height / 2
        var leftOffset: CGFloat = xPercent * bounds.size.width - width / 2

        if topOffset <= .zero {
            topOffset = Constants.PointInfoView.minTopOffest
        }

        if topOffset + height >= rootHeight {
            topOffset = rootHeight - height - Constants.PointInfoView.minTopOffest
        }

        if leftOffset <= .zero {
            leftOffset = Constants.PointInfoView.minLeftOffset
        }

        if leftOffset + width >= rootWidth {
            leftOffset = rootWidth - width - Constants.PointInfoView.minLeftOffset
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

        pointInfoView.backgroundColor = Constants.PointInfoView.backgroundColor
        pointInfoView.layer.cornerRadius = Constants.PointInfoView.cornerRadius
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

        pointInfoView.alpha = Constants.PointInfoViewAnimation.startAlpha
        UIView.animate(withDuration: Constants.PointInfoViewAnimation.duration) {
            self.pointInfoView.alpha = Constants.PointInfoViewAnimation.endAlpha
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

        struct PointInfoView {
            static let backgroundColor: UIColor = UIColor(red: 113 / 255,
                                                          green: 101 / 255,
                                                          blue: 227 / 255,
                                                          alpha: 0.8)
            static let cornerRadius: CGFloat = 15

            static let minTopOffest: CGFloat = 1

            static let minLeftOffset: CGFloat = 1

            static let widthPercent: Percent = 20%
        }

        struct PointInfoViewAnimation {
            static let startAlpha: CGFloat = 1

            static let endAlpha: CGFloat = 0

            static let duration: TimeInterval = 2.5
        }
    }
}
