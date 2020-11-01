import Foundation
import CoreData

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatarURL: NSURL
    @NSManaged public var balance: NSDecimalNumber
    @NSManaged public var name: String
    @NSManaged public var surname: String
    @NSManaged public var totalSpent: NSDecimalNumber
}
