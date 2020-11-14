//
//  MeHistoryFilterPresenter.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 14.11.2020.
//

import Foundation

class MeHistoryFilterPresenter {
    weak var view: MeHistoryFilterInput?

    private var sortBy: SortBy?
    private var typeOfSort: TypeOfSort?

}

extension MeHistoryFilterPresenter: MeHistoryFilterOutput {
    func didOkButtonTapped() {
        print("Type of sort:", typeOfSort as Any)
        print("Sort By:", sortBy as Any)
    }
}

extension MeHistoryFilterPresenter: FilterDelegate {
    func didChangeTypeOfSort(typeOfSort: TypeOfSort) {
        self.typeOfSort = typeOfSort
    }

    func didChangeSortBy(sortBy: SortBy) {
        self.sortBy = sortBy
    }
}

extension MeHistoryFilterPresenter: SortByDelegate {
    
}
