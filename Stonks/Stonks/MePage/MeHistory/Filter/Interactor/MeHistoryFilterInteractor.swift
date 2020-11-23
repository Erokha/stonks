import Foundation

final class MeHistoryFilterInteractor {
    weak var output: MeHistoryFilterInteractorOutput?
    weak var meHistoryFilterDelegate: MeHistoryFilterDelegate?

    private func handle(stocks: [StockHistory]) {
        let stocksData: [StockHistoryData] = stocks.map({ StockHistoryData(with: $0) })
        output?.didSortedStocksLoaded(with: stocksData)
    }
}

extension MeHistoryFilterInteractor: MeHistoryFilterInteractorInput {
    func loadHistoryStocks(with type: TypeOfAction?, sortBy: SortBy?) {
        if let stocks = StockHistoryDataService.shared.getStocks(with: type, sortby: sortBy) {
            handle(stocks: stocks)
        } else {
            handle(stocks: [])
        }
    }
}
