import Foundation
import UIKit
import PinLayout
import Kingfisher

class StockTableViewCell: UITableViewCell {

    // @IBOutlet var image: UIImageView!
    private weak var stockNameLabel: UILabel!
    private weak var stockPriceLabel: UILabel!
    private weak var stockCountLabel: UILabel!
    // private weak var arrowButton: UIButton!
    private weak var stockImageView: UIImageView!
    // private weak var container: UIView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    override func layoutSubviews() {
        layoutUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }

    func setData(data: StockData) {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        // setupUI()
        self.setShadow()
        self.stockNameLabel.text = data.stockName
        self.stockPriceLabel.text = String(data.stockPrice) + "$"
        self.stockCountLabel.text = "you own: \(data.stockCount)"
        let url = URL(string: data.imageUrl)
        self.stockImageView.kf.setImage(with: url)
    }

    private func setShadow() {
        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
        self.contentView.backgroundColor = Constants.backgroundColor
    }
}

extension StockTableViewCell {
    private func setupUI() {
        backgroundColor = Constants.backgroundColor
        setupStockImageView()
        setupStockCountLabel()
        setupStockPriceLabel()
        setupStockNameLabel()
    }

    private func layoutUI() {
        layoutStockImageView()
        layoutStockCountLabel()
        layoutStockPriceLabel()
        layoutStockNameLabel()
    }

    // MARK: stockImageView

    private func setupStockImageView() {
        let imageView = UIImageView()
        stockImageView = imageView
        contentView.addSubview(stockImageView)
    }

    private func layoutStockImageView() {
        stockImageView.pin
            .left(13)
            .top(10)
            .width(34)
            .bottom(5)
    }

    // MARK: Stock Name Label

    private func setupStockNameLabel() {
        let label = UILabel()
        stockNameLabel = label
        stockNameLabel.textColor = Constants.textColor
        stockNameLabel.textAlignment = .center
        stockNameLabel.font = Constants.nameLabelFont
        contentView.addSubview(stockNameLabel)
    }

    private func layoutStockNameLabel() {
        stockNameLabel.pin
            .after(of: stockImageView)
            .before(of: stockPriceLabel)
            .height(33)
            .vCenter()
            .marginHorizontal(5)
    }

    // MARK: Stock Count Label

    private func setupStockCountLabel() {
        let label = UILabel()
        stockCountLabel = label
        stockCountLabel.textColor = Constants.textColor
        stockCountLabel.font = Constants.countLabelFont
        stockCountLabel.contentMode = .right
        contentView.addSubview(stockCountLabel)
    }

    private func layoutStockCountLabel() {
        stockCountLabel.pin
            .right(22)
            .height(23)
            .sizeToFit()
            .bottom(2)

    }

    // MARK: Stock Price Label() {

    private func setupStockPriceLabel() {
        let label = UILabel()
        stockPriceLabel = label
        stockPriceLabel.textColor = Constants.greenColor
        stockPriceLabel.font = Constants.priceLabelFont
        stockPriceLabel.contentMode = .right
        contentView.addSubview(stockPriceLabel)
    }

    private func layoutStockPriceLabel() {
        stockPriceLabel.pin
            .right(22)
            .height(12)
            .sizeToFit()
            .top(2)
    }

    // MARK: Color updates

    private func updateColors() {
        stockNameLabel.textColor = Constants.textColor
        stockCountLabel.textColor = Constants.textColor
        backgroundColor = Constants.backgroundColor
    }
}

extension StockTableViewCell {
    private struct Constants {

        static let nameLabelFont = UIFont(name: "DMSans-Bold", size: 17)

        static let priceLabelFont = UIFont(name: "DMSans-Medium", size: 17)

        static let countLabelFont = UIFont(name: "DMSans-Medium", size: 10)

        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 1)
            } else {
                return .white
            }
        }

        static var textColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 249 / 255,
                               green: 249 / 255,
                               blue: 251 / 255,
                               alpha: 1)
            } else {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 1)
            }
        }

        static let greenColor: UIColor = UIColor(red: 71 / 255,
                                        green: 190 / 255,
                                        blue: 162 / 255,
                                        alpha: 1)

        static var shadowColor: CGColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor.black.cgColor
            } else {
                return UIColor.gray.cgColor
            }
        }
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
