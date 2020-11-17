//
//  FilterProtocols.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 14.11.2020.
//

import Foundation

protocol MeHistoryFilterInput: class {
    func stocksLoaded(stocks: [StockHistoryData])
}

protocol MeHistoryFilterOutput: TypeOfSortDelegate, SortByDelegate {
    func didOkButtonTapped()
    func didChangeTypeOfSort(typeOfSort: TypeOfAction?)
    func didChangeSortBy(sortBy: SortBy)
}

protocol MeHistoryFilterInteractorOutput: class {
    func didSortedStocksLoaded(with sotcks: [StockHistoryData])
}

protocol MeHistoryFilterInteractorInput: class {
    func loadHistoryStocks(with type: TypeOfAction?, sortBy: SortBy?)
}

protocol FilterDelegate: TypeOfSortDelegate, SortByDelegate {
}
