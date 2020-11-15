import Foundation

class MeHistoryFilterInteractor {
    weak var output: MeHistoryFilterInteractorOutput?
}

extension MeHistoryFilterInteractor: MeHistoryFilterInteractorInput {
    func loadHistoryStocks(with type: TypeOfAction?, sortBy: SortBy?) {
        if let allStocks = StockHistoryDataService.shared.getAllStocks() {
            for stock in allStocks {
                print(stock.price)
            }
        }
        if let stocksType = StockHistoryDataService.shared.getStocks(with: type, sortby: sortBy) {
            for stock in stocksType {
                print(stock.price)
            }
        }
    }
}
