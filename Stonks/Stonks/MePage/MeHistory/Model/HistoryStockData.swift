import UIKit

struct StockHistoryData {
    var name: String
    var symbol: String
    var price: Double
    var image: UIImage?
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
//        let imageUrl = stockHistory.imageURL
//        if let image = UIImage(contentsOfFile: imageUrl.path ?? "") {
//                self.image = image
//        }
        self.date = StockHistoryData.convertDate(with: stockHistory.date)
        self.type = TypeOfAction(rawValue: Int(stockHistory.type)) ?? .bought
    }
}
