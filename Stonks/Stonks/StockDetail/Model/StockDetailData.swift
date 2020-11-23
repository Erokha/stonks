import Foundation

struct StockPresenterData {
    var name: String?
    var symbol: String?
    var amount: Int?
    var quotes: [NSDecimalNumber]?

    var cardData: CardData?

    init(model: StockInteractorData) {
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

struct StockInteractorData {
    var name: String
    var symbol: String
    var totalCost: NSDecimalNumber
    var amount: NSInteger
    var priceHistory: [NSDecimalNumber]

    init(stock: Stock) {
        self.name = stock.name
        self.symbol = stock.symbol
        self.totalCost = stock.totalCost
        self.amount = stock.amount
        self.priceHistory = stock.priceHistory
    }

    init(name: String, symbol: String) {
        self.name = name
        self.symbol = symbol
        self.totalCost = 0
        self.amount = 0
        self.priceHistory = []
    }
}

struct CardData {
    var leftNumber: Int
    var rightNumber: Int
}
