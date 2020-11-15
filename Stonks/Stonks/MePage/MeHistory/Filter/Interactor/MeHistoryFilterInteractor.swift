import Foundation

class MeHistoryFilterInteractor {
    weak var output: MeHistoryFilterInteractorOutput?
}

extension MeHistoryFilterInteractor: MeHistoryFilterInteractorInput {
    func loadHistoryStocks(type: TypeOfAction?, sortBy: SortBy?) {
        if let typeOfAction = type {
            let stocksType = StockHistoryDataService.shared.getStocks(with: typeOfAction)
            print(stocksType)
        } else {
            let stocks = StockHistoryDataService.shared.getAllStocks()
            if let coolStocks = stocks {
                let stock = coolStocks.first
                print(stock?.type)
            }
        }
    }
}
