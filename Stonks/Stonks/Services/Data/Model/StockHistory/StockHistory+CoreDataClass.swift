import Foundation
import CoreData

extension StockHistory {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<StockHistory> {
        return NSFetchRequest<StockHistory>(entityName: Entities.stockHistory.rawValue)
    }

    @NSManaged public var name: String
    @NSManaged public var symbol: String
    @NSManaged public var price: Double
    @NSManaged public var date: Date
    @NSManaged public var type: Int16
}
