import Foundation

struct StockDetailPresenterData {
    var name: String?
    var quotes: [NSDecimalNumber]?

    init(model: Stock) {
        self.name = model.name
        self.quotes = model.priceHistory
    }

    init() {

    }
}
