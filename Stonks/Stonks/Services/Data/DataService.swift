import Foundation
import CoreData

class DataService {
    static var shared = DataService()

    private init() {

    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}

extension DataService: AuthorizationServiceInput {
    func userIsAuthorized() -> Bool {
        guard let isAuthorizedObject = UserDefaults.standard.value(forKeyPath: "isAuthorized") else {
            return false
        }

        guard let isAuthorized = isAuthorizedObject as? Bool else {
            return false
        }

        return isAuthorized
    }

    func authorize() {
        UserDefaults.standard.setValue(true, forKey: "isAuthorized")
    }
}

extension DataService: CoreDataServiceInput {
    func createUser(name: String, surname: String, balance: Decimal) {
        let context = persistentContainer.viewContext

        guard let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User else {
            print("User not saved")
            return
        }

        user.name = name
        user.surname = surname
        user.balance = NSDecimalNumber(decimal: balance)

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
                print("Unable to cast CoreData entitiy to User")
                return nil
            }

            return users.first

        } catch {
            print(error)
            return nil
        }
    }
}
