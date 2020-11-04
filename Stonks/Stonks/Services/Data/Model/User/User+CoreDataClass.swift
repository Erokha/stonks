import Foundation
import CoreData

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: Entities.user.rawValue)
    }

    @NSManaged public var avatarURL: NSURL
    @NSManaged public var balance: NSDecimalNumber
    @NSManaged public var name: String
    @NSManaged public var surname: String
    @NSManaged public var totalSpent: NSDecimalNumber

    @NSManaged public var stocks: NSSet?
}
