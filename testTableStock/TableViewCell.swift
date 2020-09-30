//
//  TableViewCell.swift
//  testTableStock
//
//  Created by kymblc on 30.09.2020.
//  Copyright © 2020 traceback. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    var symbol: String!
    
    func configure(arrivedStock: stockStruct) {
        self.stockName.text = arrivedStock.name
        self.stockPrice.text = String(arrivedStock.price)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
