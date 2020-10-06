//
//  ChartExtention.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 06.10.2020.
//

import Foundation
import Charts

extension MePortfolioViewController {
    func configurePieChart() {
        self.stocksPieChartView.chartDescription?.enabled = true
        self.stocksPieChartView.drawHoleEnabled = false
        self.stocksPieChartView.rotationAngle = 0
        self.stocksPieChartView.isUserInteractionEnabled = false
        
        var stocks: [PieChartDataEntry] = Array()
        stocks.append(PieChartDataEntry(value: 12, label: "AAPL"))
        stocks.append(PieChartDataEntry(value: 10, label: "Google"))
        
        let dataSet = PieChartDataSet(entries: stocks, label: "")
         
        let c1 = NSUIColor(cgColor: UIColor.blue.cgColor)
        let c2 = NSUIColor(cgColor: UIColor.red.cgColor)
        
        dataSet.colors = [c1, c2]
        dataSet.drawValuesEnabled = false
        
        self.stocksPieChartView.data = PieChartData(dataSet: dataSet)
        
    }
}
