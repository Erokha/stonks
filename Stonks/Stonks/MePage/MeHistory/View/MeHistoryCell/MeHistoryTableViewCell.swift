//import UIKit
//
//final class MeHistoryTableViewCell: UITableViewCell {
//
//    @IBOutlet private weak var nameLabel: UILabel!
//    @IBOutlet private weak var logoImageView: UIImageView!
//    @IBOutlet private weak var dateLabel: UILabel!
//    @IBOutlet private weak var imageAreaView: UIView!
//    @IBOutlet private weak var priceLabel: UILabel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    private func setupCell() {
//        imageAreaView.layer.cornerRadius = MeHistoryTableViewCell.Constants.viewRadius
//        imageAreaView.layer.shadowColor = UIColor.gray.cgColor
//        imageAreaView.layer.shadowRadius = MeHistoryTableViewCell.Constants.shadowRadius
//        imageAreaView.layer.shadowOffset = .init(width: 0, height: 2)
//        imageAreaView.layer.shadowOpacity = MeHistoryTableViewCell.Constants.shadowOpacity
//        logoImageView.layer.cornerRadius = MeHistoryTableViewCell.Constants.imageRadius
//        self.layoutMargins = UIEdgeInsets.zero
//        self.preservesSuperviewLayoutMargins = false
//    }
//
//    func setData(stock: StockHistoryData) {
//        setupCell()
//        nameLabel.text = stock.name
//        priceLabel.text = String(stock.price) + "$"
//        dateLabel.text = stock.date
//        let url = URL(string: stock.imageUrl ?? "")
//        self.logoImageView.kf.setImage(with: url)
//        switch stock.type {
//        case .bought:
//            priceLabel.textColor = #colorLiteral(red: 0.2784313725, green: 0.7450980392, blue: 0.6352941176, alpha: 1)
//        case .sold:
//            priceLabel.textColor = #colorLiteral(red: 0.862745098, green: 0.2196078431, blue: 0.231372549, alpha: 1)
//        }
//    }
//}
//
//extension MeHistoryTableViewCell {
//    private struct Constants {
//        static let viewRadius: CGFloat = 15
//        static let shadowRadius: CGFloat = 1
//        static let shadowOpacity: Float = 0.4
//        static let legendFormSize: CGFloat = 15
//        static let imageRadius: CGFloat = 10
//    }
//}
