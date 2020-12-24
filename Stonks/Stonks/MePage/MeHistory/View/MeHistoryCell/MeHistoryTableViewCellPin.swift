import UIKit
import PinLayout

final class MeHistoryTableViewCell: UITableViewCell {
    static let identifier = "MethodCell"

    private let imageAreaView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.cornerRadius = Constants.viewRadius
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = 1
        view.layer.shadowOffset = .init(width: 0, height: 2)
        view.layer.shadowOpacity = Constants.shadowOpacity
        return view
    }()

    private let logoImageView: UIImageView  = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.imageRadius
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DMSans-Bold", size: 17)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DMSans-Regular", size: 15)
        label.textAlignment = .center
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DMSans-Regular", size: 12)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkTheme()
        selectionStyle = .none
        addSubview(imageAreaView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageAreaView()
        setupImageView()
        setupNameLabel()
        setupPriceLabel()
        setupDateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            contentView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
        } else {
            contentView.backgroundColor = .white
        }
    }

    private func setupImageAreaView() {
        imageAreaView.pin
            .vCenter()
            .left(8)
            .width(38)
            .height(36)
    }

    private func setupImageView() {
        imageAreaView.addSubview(logoImageView)
        logoImageView.pin
            .center()
            .height(25)
            .width(25)
    }

    private func setupNameLabel() {
        nameLabel.pin
            .after(of: imageAreaView)
            .margin(12)
            .height(40)
            .vCenter()
            .sizeToFit(.height)
    }

    private func setupPriceLabel() {
        priceLabel.pin
            .vCenter(-15%)
            .right(contentView.pin.safeArea.right + 8)
            .width(70)
            .sizeToFit(.width)
    }

    private func setupDateLabel() {
        dateLabel.pin
            .vCenter(15%)
            .right(contentView.pin.safeArea.right + 8)
            .width(70)
            .sizeToFit(.width)
    }
    private func setupCell() {
        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
    }

    func setData(stock: StockHistoryData) {
        setupCell()
        nameLabel.text = stock.name
        priceLabel.text = String(stock.price) + "$"
        dateLabel.text = stock.date
        let url = URL(string: stock.imageUrl ?? "")
        self.logoImageView.kf.setImage(with: url)
        switch stock.type {
        case .bought:
            priceLabel.textColor = #colorLiteral(red: 0.2784313725, green: 0.7450980392, blue: 0.6352941176, alpha: 1)
        case .sold:
            priceLabel.textColor = #colorLiteral(red: 0.862745098, green: 0.2196078431, blue: 0.231372549, alpha: 1)
        }
    }
}

extension MeHistoryTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 1
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
        static let imageRadius: CGFloat = 10
    }
}
