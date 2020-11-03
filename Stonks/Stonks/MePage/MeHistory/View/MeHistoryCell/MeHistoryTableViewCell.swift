import UIKit

class MeHistoryTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(stock: Stock) {
        nameLabel.text = stock.stockName
        priceLabel.text = String(stock.stockPrice)
        let url = URL(string: stock.imageUrl)
        logoImageView.kf.setImage(with: url)
    }
}
