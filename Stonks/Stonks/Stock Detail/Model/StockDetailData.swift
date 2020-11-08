import Foundation

struct StockDetailPresenterData {
    var name: String
    var freshPrice: Decimal?
    var quotes: [(Double, Double)]?

    init(name: String) {
        self.name = name
    }

    init(model: StockDetailInteractorData) {
        self.name = model.name
        self.quotes = model.quotes

        guard let stock = model.stock else {
            freshPrice = nil
            return
        }

        self.freshPrice = stock.freshPrice as Decimal
    }
}

struct StockDetailInteractorData {
    var name: String
    var quotes: [(Double, Double)]?
    var stock: Stock?

    init(name: String) {
        self.name = name
    }
}
