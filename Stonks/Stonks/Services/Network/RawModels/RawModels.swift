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

struct HistoryRaw: Decodable {
    let date: String
    let open: Float
    let low: Float
    let high: Float
    let close: Float
    let volume: Int

    private enum CodingKeys: String, CodingKey {
        case date
        case open
        case low
        case high
        case close
        case volume
    }
}
