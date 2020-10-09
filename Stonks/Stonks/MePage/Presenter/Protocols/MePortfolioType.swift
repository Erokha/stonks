//
//  MePortfolioProtocol.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 07.10.2020.
//

import Foundation
import Charts

protocol MePortfolioOutput {
    func countStocks()
    func createDataEntity()
    func generateColors()
}
