//
//  HeaderViewController.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 06.10.2020.
//

import UIKit



class HeaderViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoundCorners11()
        configureUi()
    }
}

extension HeaderViewController {
    func setRoundCorners11() {
        self.headerView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            self.headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
}

extension HeaderViewController {
    func configureUi(){
        self.headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        self.headerView.layer.shadowRadius = 20
        self.headerView.layer.shadowOpacity = 0.8
        self.profileImage.image = UIImage(named: "ZUEV")
        self.profileImage.layer.cornerRadius = 15
    }
}

