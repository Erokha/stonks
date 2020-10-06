//
//  MeProfileViewController.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 06.10.2020.
//

import UIKit

class MePortfolioViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUi()
    }
}


extension MePortfolioViewController
{
    func configureUi(){
        self.headerView.layer.cornerRadius = 20
        self.headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        self.headerView.layer.shadowRadius = 20
        self.headerView.layer.shadowOffset = .zero
        self.headerView.layer.shadowOpacity = 0.8
    }
}
