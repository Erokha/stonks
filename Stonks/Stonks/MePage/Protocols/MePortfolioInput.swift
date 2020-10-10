//
//  MePortfolioInput.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 10.10.2020.
//

import Foundation
import Charts

protocol MePortfolioInput {
    func configureUi()
    
    func chartSettings()
    
    func drawDiagramm(pieChartData: PieChartData)
    
}
