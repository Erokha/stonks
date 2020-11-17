import Foundation

struct StockDetailPresenterData {
    var name: String?
    var amount: Int?
    var quotes: [NSDecimalNumber]?

    var cardData: CardData?

    init(model: Stock) {
        self.name = model.name
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
