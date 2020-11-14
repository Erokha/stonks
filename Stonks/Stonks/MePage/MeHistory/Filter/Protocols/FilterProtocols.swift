//
//  FilterProtocols.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 14.11.2020.
//

import Foundation

protocol MeHistoryFilterInput: class {
}

protocol MeHistoryFilterOutput: TypeOfSortDelegate, SortByDelegate {
    func didOkButtonTapped()
}

protocol FilterDelegate: TypeOfSortDelegate, SortByDelegate {
}
