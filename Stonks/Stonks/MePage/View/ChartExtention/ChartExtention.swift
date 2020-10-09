//
//  ChartExtention.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 06.10.2020.
//

import Foundation
import Charts


// Chart extention

extension MePortfolioViewController {
    private func chartSettings() {
        
        self.stocksPieChartView.chartDescription?.enabled = true
        self.stocksPieChartView.drawHoleEnabled = false
        self.stocksPieChartView.rotationAngle = 0
        self.stocksPieChartView.isUserInteractionEnabled = false
    }
    
    func addToChartDataEntity(chartValue: Double, chartLabel: String) {
        self.chartStocks.append(PieChartDataEntry(value: chartValue, label: chartLabel))
    }
    
    func setColorsToDataSet(colors: [String]) {
        
    }
    
    
    func drawDiagramm() {
        let dataSet = PieChartDataSet(entries: self.chartStocks, label: "")
         
        let c2 = NSUIColor(cgColor: UIColor.red.cgColor)
        
        dataSet.colors = [c1, c2]
        dataSet.drawValuesEnabled = false
        
        self.stocksPieChartView.data = PieChartData(dataSet: dataSet)
        
    }
}
