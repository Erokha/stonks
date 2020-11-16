//
//  MeHistoryFilterPresenter.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 14.11.2020.
//

import Foundation

final class MeHistoryFilterPresenter {
    weak var view: MeHistoryFilterInput?
    private var interactor: MeHistoryFilterInteractorInput
    private var sortBy: SortBy?
    private var typeOfSort: TypeOfAction?

    init(interactor: MeHistoryFilterInteractorInput) {
        self.interactor = interactor
    }
}

extension MeHistoryFilterPresenter: MeHistoryFilterOutput {
    func didChangeSortBy(sortBy: SortBy) {
        self.sortBy = sortBy
    }

    func didChangeTypeOfSort(typeOfSort: TypeOfAction?) {
        self.typeOfSort = typeOfSort
    }

    func didOkButtonTapped() {
        interactor.loadHistoryStocks(with: typeOfSort, sortBy: sortBy)
    }
}

extension MeHistoryFilterPresenter: MeHistoryFilterInteractorOutput {
    func didSortedStocksLoaded(with sotcks: [StockHistoryData]) {
        view?.stocksLoaded(stocks: sotcks)
    }
}
