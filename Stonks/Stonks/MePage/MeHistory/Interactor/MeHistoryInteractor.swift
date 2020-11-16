import Foundation

final class MeHistoryInteractor {
    weak var output: MeHistoryInteractorOutput?

    private func handle(stocks: [StockHistory]) {
        let stocksData: [StockHistoryData] = stocks.map({ StockHistoryData(with: $0) })
        output?.didReceive(stocks: stocksData)
    }
}

extension MeHistoryInteractor: MeHistoryInteractorInput {
    func loadStocks() {
        if let stocks = StockHistoryDataService.shared.getStocks(with: nil, sortby: .descendingDate) {
            handle(stocks: stocks)
        }
    }
}
