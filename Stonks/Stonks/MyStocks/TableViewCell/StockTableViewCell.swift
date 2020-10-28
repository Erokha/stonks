//
//  TableViewCell.swift
//  ochko
//
//  Created by kymblc on 08.10.2020.
//

import UIKit

class StockTableViewCell: UITableViewCell {

    //@IBOutlet var image: UIImageView!
    @IBOutlet private weak var stockNameLabel: UILabel!
    @IBOutlet private weak var stockPriceLabel: UILabel!
    @IBOutlet private weak var stockCountLabel: UILabel!
    @IBOutlet private weak var arrowButton: UIButton!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(data: Stock) {
        self.stockNameLabel.text = data.stockName
        self.stockPriceLabel.text = String(data.stockPrice) + "$"
        self.stockCountLabel.text = "you own: \(data.stockCount)"
    }

}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
