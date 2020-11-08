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

extension DataService {
    private struct Constants {
        static var modelName: String = "Model"
    }
}
