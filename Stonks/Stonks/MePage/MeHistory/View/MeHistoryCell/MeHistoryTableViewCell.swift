import UIKit

class MeHistoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var imageAreaView: UIView!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setupCell() {
        imageAreaView.layer.cornerRadius = MeHistoryTableViewCell.Constants.viewRadius
        imageAreaView.layer.shadowColor = UIColor.black.cgColor
        imageAreaView.layer.shadowRadius = MeHistoryTableViewCell.Constants.shadowRadius
        imageAreaView.layer.shadowOffset = .init(width: 0, height: 2)
        imageAreaView.layer.shadowOpacity = MeHistoryTableViewCell.Constants.shadowOpacity
        logoImageView.layer.cornerRadius = MeHistoryTableViewCell.Constants.imageRadius
        self.layoutMargins = UIEdgeInsets.zero

        self.preservesSuperviewLayoutMargins = false
    }
    func setData(stock: StockData) {
        setupCell()
        logoImageView.image = UIImage(named: "ZUEV")
        nameLabel.text = stock.stockName
        priceLabel.text = String(stock.stockPrice) + "$"
        let url = URL(string: stock.imageUrl)
        logoImageView.kf.setImage(with: url)
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
