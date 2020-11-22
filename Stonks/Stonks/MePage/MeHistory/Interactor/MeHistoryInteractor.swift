import Foundation

final class MeHistoryInteractor {
    weak var output: MeHistoryInteractorOutput?

    private func handle(stocks: [StockHistory]) {
        let stocksData: [StockHistoryData] = stocks.map({ StockHistoryData(with: $0) })
        output?.didReceive(newStocks: stocksData)
    }
}

extension MeHistoryInteractor: MeHistoryInteractorInput {
    func loadImageUrl(for stocks: [String]) {
        NetworkService.shared.fetchStockImageUrl(for: stocks) { (result) in
            if result.error != nil {
                return
            }
            guard let imageUrls = result.data else { return }

            self.output?.didReceiveImage(images: imageUrls)
        }
    }

    func loadStocks() {
        if let stocks = StockHistoryDataService.shared.getStocks(with: nil, sortby: .descendingDate) {
            handle(stocks: stocks)
        }
    }
}
