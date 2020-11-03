import Foundation
import CoreData

extension Stock {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stock> {
        return NSFetchRequest<Stock>(entityName: Entities.stock.rawValue)
    }

    @NSManaged public var name: String
    @NSManaged public var symbol: String
    @NSManaged public var price: NSDecimalNumber
    @NSManaged public var amount: NSInteger
    @NSManaged public var imageURL: NSURL
}
