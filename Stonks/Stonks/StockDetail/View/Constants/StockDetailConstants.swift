import UIKit
import PinLayout

extension StockDetailViewController {
    internal struct Constants {
        static let backgroundColor: UIColor = .white

        static let chartLineColor: UIColor = UIColor(red: 113 / 255,
                                                     green: 101 / 255,
                                                     blue: 227 / 255,
                                                     alpha: 1)

        static let chartFillColor: UIColor = UIColor(red: 113 / 255,
                                                     green: 101 / 255,
                                                     blue: 227 / 255,
                                                     alpha: 0.6)

        static let textFieldTextLeftSpacing: CGFloat = 10

        static let textFieldTextRightSpacing: CGFloat = 10

        struct CompanyNameLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Medium", size: 15)
            static let numberOfLines: Int = 2
        }

        struct ChartDataset {
            static let circleRadius: CGFloat = 3
            static let lineWidth: CGFloat = 1
        }

        struct StockDetailCardView {
            static let cornerRadius: CGFloat = 20
        }

        struct ShowMyStocksButton {
            static let imageName: String = "previous"
        }

        struct StockDetailCardContainerView {
            static let cornerRadius: CGFloat = 20
            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct ChartContainerView {
            static let cornerRadius: CGFloat = 20
            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct StockSymbolLabel {
            static let font = UIFont(name: "DMSans-Bold", size: 30)
        }

        struct StockCurrentCostLabel {
            static let font = UIFont(name: "DMSans-Bold", size: 24)
        }

        struct StockLineChartView {
            static let backgoundColor: UIColor = .white
            static let cornerRadius: CGFloat = 20
            static let minOffset: CGFloat = 0

        }

        struct StockAmountLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Medium", size: 12)
        }

        struct BuyButton {
            static let backgroundColor: UIColor = UIColor(red: 71 / 255,
                                                          green: 190 / 255,
                                                          blue: 162 / 255,
                                                          alpha: 1)

            static let text: String = "Buy"
            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 17)
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

            static let text: String = "Sell"
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
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 15)

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
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 15)

            static let shadowColor: UIColor = .black
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }

        struct CardView {
            static let rightText: String = "Your Amount Price"
            static let leftText: String = "Available Balance"
        }

        struct TapRecognizer {
            static let tapsRequired: Int = 1
        }
    }
}
