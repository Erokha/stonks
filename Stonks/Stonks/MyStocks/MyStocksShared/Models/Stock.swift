struct StockData {
    let stockName: String
    let stockSymbol: String
    var stockPrice: Float
    var stockCount: Int
    let imageUrl: String

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
        self.imageUrl = coreStock.imageURL.path ?? "not found"
        self.stockCount = coreStock.amount
    }
}

struct StockRaw: Decodable {
    let stockName: String
    let stockSymbol: String
    let stockPrice: Float
    let imageUrl: String

    private enum CodingKeys: String, CodingKey {
        case stockName = "companyName"
        case stockSymbol = "symbol"
        case stockPrice = "price"
        case imageUrl = "image"
    }
}
