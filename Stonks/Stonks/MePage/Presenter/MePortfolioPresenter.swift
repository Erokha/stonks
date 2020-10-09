//
//  MePortfolioPresenter.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 07.10.2020.
//

import UIKit
import Charts

class MePortfolioPresenter: MePortfolioOutput {
    unowned let view: MePortfolioViewController
    var stocks: [Stock] = []
    var chartColors: [NSUIColor] = []
    
    required init(view: MePortfolioViewController) {
        self.view = view
    }

    func countStocks() {
        
    }
    
    func createDataEntity() {
        
    }
    
    func generateColors() {
        chartColors.append(NSUIColor(named: ChartColors.purple.rawValue)
        chartColors.append(ChartColors.pink.rawValue)
        chartColors.append(ChartColors.green.rawValue)
        chartColors.append(ChartColors.blue.rawValue)
        chartColors.append(ChartColors.yellow.rawValue)
    }
}
