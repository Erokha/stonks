import UIKit
import Kingfisher

struct StockHistoryData {
    var name: String
    var symbol: String
    var price: Double
    var imageUrl: String?
    var date: String
    var type: TypeOfAction

    static func convertDate(with date: Date) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "YY/MM/dd"

        return dateFormatter.string(from: date)
    }

    init(with stockHistory: StockHistory) {
        self.name = stockHistory.name
        self.symbol = stockHistory.symbol
        self.price = stockHistory.price
        self.date = StockHistoryData.convertDate(with: stockHistory.date)
        self.type = TypeOfAction(rawValue: Int(stockHistory.type)) ?? .bought
    }
}
