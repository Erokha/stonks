import UIKit
import Kingfisher

class StockTableViewCell: UITableViewCell {

    //@IBOutlet var image: UIImageView!
    @IBOutlet private weak var stockNameLabel: UILabel!
    @IBOutlet private weak var stockPriceLabel: UILabel!
    @IBOutlet private weak var stockCountLabel: UILabel!
    @IBOutlet private weak var arrowButton: UIButton!
    @IBOutlet private weak var newsImageView: UIImageView!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(data: StockData) {
        self.stockNameLabel.text = data.stockName
        self.stockPriceLabel.text = String(data.stockPrice) + "$"
        self.stockCountLabel.text = "you own: \(data.stockCount)"
        let url = URL(string: data.imageUrl)
        self.newsImageView.kf.setImage(with: url)
    }

}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
