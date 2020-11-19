struct StockData {
    let stockName: String
    let stockSymbol: String
    var stockPrice: Float
    var stockCount: Int
    var imageUrl: String

    init(with raw: StockRaw) {
        self.stockName = raw.stockName
        self.stockSymbol = raw.stockSymbol
        self.stockPrice = raw.stockPrice
        self.imageUrl = raw.imageUrl
        self.stockCount = 0
    }

    init(with coreStock: Stock) {
        self.stockName = coreStock.name
        self.stockSymbol = coreStock.symbol
        self.stockPrice = 0
        self.imageUrl = "not found"
        self.stockCount = coreStock.amount
    }
}
