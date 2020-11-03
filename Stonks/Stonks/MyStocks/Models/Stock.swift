struct Stock {
    let stockName: String
    let stockSymbol: String
    let stockPrice: Float
    var stockCount: Int
    let imageUrl: String

    init(with raw: StockRaw) {
        self.stockName = raw.stockName
        self.stockSymbol = raw.stockSymbol
        self.stockPrice = raw.stockPrice
        self.imageUrl = raw.imageUrl
        self.stockCount = 0
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
