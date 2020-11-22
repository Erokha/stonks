import Foundation

struct MePortfolioStockData {
    let stockName: String
    let stockSymbol: String
    let amount: Int
    var currentPrice: Float

    init(with stock: Stock, currentPrice: Float) {
        self.stockName = stock.name
        self.stockSymbol = stock.symbol
        self.amount = stock.amount
        self.currentPrice = currentPrice
    }
}
