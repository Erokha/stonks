import Foundation

struct StockDetailPresenterData {
    var name: String?
    var symbol: String?
    var amount: Int?
    var quotes: [NSDecimalNumber]?

    var cardData: CardData?

    init(model: Stock) {
        self.name = model.name
        self.symbol = model.symbol
        self.amount = model.amount
        self.quotes = model.priceHistory
    }

    init(cardData: CardData) {
        self.cardData = cardData
    }

    init() {

    }
}

struct CardData {
    var leftNumber: Int
    var rightNumber: Int
}
