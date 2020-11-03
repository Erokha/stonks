import Foundation
import CoreData

class DataService {
    static var shared = DataService()

    private init() {

    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.modelName)

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }

        return container
    }()

    func getPersistentContainer() -> NSPersistentContainer {
        return self.persistentContainer
    }
}

extension DataService: AuthorizationServiceInput {
    func userIsAuthorized() -> Bool {
        guard let isAuthorizedObject = UserDefaults.standard.value(forKeyPath: Constants.authKey) else {
            return false
        }

        guard let isAuthorized = isAuthorizedObject as? Bool else {
            return false
        }

        return isAuthorized
    }

    func authorize() {
        UserDefaults.standard.setValue(true, forKey: Constants.authKey)
    }
}

extension DataService: CoreDataServiceInput {
  func createUser(name: String, surname: String, balance: Decimal) {
        let context = persistentContainer.viewContext

        guard let user = NSEntityDescription.insertNewObject(forEntityName: Entities.user.rawValue, into: context) as? User else {
            return
        }

        user.name = name
        user.surname = surname
        user.balance = NSDecimalNumber(decimal: balance)
        user.totalSpent = NSDecimalNumber(decimal: 0)

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

    func createStock(name: String, symbol: String, curPrice: Decimal, imageURL: URL, amount: Int = 0) {
        let context = persistentContainer.viewContext

        guard let stock = NSEntityDescription.insertNewObject(forEntityName: Entities.stock.rawValue, into: context) as? Stock else {
            return
        }

        stock.name = name
        stock.symbol = symbol
        stock.price = NSDecimalNumber(decimal: curPrice)
        stock.amount = amount
        stock.imageURL = NSURL(fileURLWithPath: imageURL.absoluteString)

        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    func getStock(with name: String) -> Stock? {
        let context = persistentContainer.viewContext
        let stockFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stock.rawValue)

        let predicate = NSPredicate(format: "name == %@", name)

        stockFetchRequest.predicate = predicate

        do {
            let fetchResult = try context.fetch(stockFetchRequest)

            guard !fetchResult.isEmpty else {
                return nil
            }

            return fetchResult[0] as? Stock
        } catch {
            print(error)
            return nil
        }
    }

    func updateStock(name: String, stock: Stock) {
        let context = persistentContainer.viewContext
        let stockFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stock.rawValue)

        let predicate = NSPredicate(format: "name == %@", name)

        stockFetchRequest.predicate = predicate

        do {
            var fetchResult = try context.fetch(stockFetchRequest)

            guard !fetchResult.isEmpty else {
                return
            }

            fetchResult[0] = stock

            try context.save()
        } catch {
            print(error)
        }
    }
}

extension DataService {
    private struct Constants {
        static var modelName: String = "Model"
        static var authKey: String = "isAuthorized"
        static var avatarImageName = "avatar.png"
    }
}
