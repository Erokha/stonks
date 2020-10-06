//
//  MeProfileViewController.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 06.10.2020.
//

import UIKit
import Charts
class MePortfolioViewController: UIViewController {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var stocksPieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePieChart()
        configureUi()
    }
}

extension MePortfolioViewController {
    func configureUi() {
        self.chartView.layer.cornerRadius = 20
        self.chartView.layer.shadowPath = UIBezierPath(rect: chartView.bounds).cgPath
        chartView.layer.shadowColor = UIColor.black.cgColor
        self.chartView.layer.shadowRadius = 10
        self.chartView.layer.shadowOffset = .zero
        self.chartView.layer.shadowOpacity = 0.6
    }
}
