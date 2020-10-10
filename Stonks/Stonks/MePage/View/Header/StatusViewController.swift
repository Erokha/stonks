//
//  StatusViewController.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 10.10.2020.
//

import UIKit

class StatusViewController: UIViewController {
    @IBOutlet var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.showUpperTextLeft(text: "Spent")
        cardView.showUpperTextRight(text: "CurrentBalance")
        cardView.showNumberLeft(num: 0)
        cardView.showNumberRight(num: 0)
        setCorners()
    }

    private func setCorners() {
        self.cardView.clipsToBounds = true
        self.cardView.layer.cornerRadius = 20
    }
}
