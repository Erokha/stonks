//
//  TableViewCell.swift
//  ochko
//
//  Created by kymblc on 08.10.2020.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    //@IBOutlet var image: UIImageView!
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var stockCount: UILabel!
    @IBOutlet var arrow: UIButton!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(data: Stock) {
        self.stockName.text = data.stockname
        self.stockPrice.text = String(data.stockprice) + "$"
        self.stockCount.text = "you own: \(data.stockCount)"
    }
    
}

