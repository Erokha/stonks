//
//  StatusViewController.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 10.10.2020.
//

import UIKit

class StatusViewController: UIViewController {
    @IBOutlet private var cardView: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cardView.showUpperTextLeft(text: StatusViewController.Constants.upperTextLeft)
        cardView.showUpperTextRight(text: StatusViewController.Constants.upperTextRight)
        setCorners()
    }

    private func setCorners() {
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = StatusViewController.Constants.cornerRadius
    }

    func setTotalSpent(spent: Int) {
        cardView.showNumberLeft(num: spent)
    }

    func setCurrentBalance(currentBalance: Int) {
        cardView.showNumberRight(num: currentBalance)
    }
}

extension StatusViewController {
    struct Constants {
        static let cornerRadius: CGFloat = 20
        static let upperTextLeft: String = "Spent"
        static let upperTextRight: String = "Current Balance"
    }
}
