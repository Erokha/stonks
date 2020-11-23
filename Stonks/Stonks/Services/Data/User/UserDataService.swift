import Foundation
import CoreData

class UserDataService {
    static let shared = UserDataService()

    private init() {

    }

    private lazy var persistentContainer: NSPersistentContainer = {
        return DataService.shared.getPersistentContainer()
    }()
}

extension UserDataService: UserDataServiceInput {
    func createUser(name: String, surname: String, balance: Decimal) {
          let context = persistentContainer.viewContext

          guard let user = NSEntityDescription.insertNewObject(forEntityName: Entities.user.rawValue, into: context) as? User else {
              return
          }

          user.name = name
          user.surname = surname
          user.balance = NSDecimalNumber(decimal: balance)
          user.totalSpent = NSDecimalNumber(decimal: balance)

          let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

          guard let avatarURL = NSURL(string: Constants.avatarImageName, relativeTo: documents) else {
              return
          }

          user.avatarURL = avatarURL

          do {
              try context.save()
          } catch {
              fatalError("Failure to save context: \(error)")
          }
      }

      func getUser() -> User? {
          let context = persistentContainer.viewContext
          let userFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.user.rawValue)

          do {
              let fetchResult = try context.fetch(userFetchRequest)

              guard let users = fetchResult as? [User],
                    !users.isEmpty else {
                  return nil
              }

              return users.first

          } catch {
              print(error)
              return nil
          }
      }

      func editUser(user: User) {
          let context = persistentContainer.viewContext
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.user.rawValue)

          do {
              var fetchReuslt = try context.fetch(fetchRequest)
              if !fetchReuslt.isEmpty {
                  fetchReuslt[0] = user
              }
              try context.save()
          } catch {
              fatalError("Failure to save context: \(error)")
          }
      }
}

extension UserDataService {
    private struct Constants {
        static var avatarImageName = "avatar.png"
    }
}
