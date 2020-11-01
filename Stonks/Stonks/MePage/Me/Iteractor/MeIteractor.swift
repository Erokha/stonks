import Foundation
import CoreData

final class MeIteractor: NSObject {
    weak var output: MeInteractorOutput?
    private var frc: NSFetchedResultsController<User>?

    required override init() {
        super.init()
        configureFrc()
        frc?.delegate = self
    }

    func configureFrc() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try frc?.performFetch()
        } catch {
            fatalError("Error while performing fetch")
        }
    }

    func prepareModels(for fetchResult: [NSFetchRequestResult]) -> User {
        if let object = fetchResult[0] as? User {
            return object
        } else {
            return User()
        }
    }

    private func handleUser(with user: User) {
        output?.didReceive(user: user)
    }
}

extension MeIteractor: MeInteractorInput {
    func loadUser() {
        if let user = DataService.shared.getUser() {
            handleUser(with: user)
        } else {
            handleUser(with: User())
        }
    }
}

extension MeIteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            let user = prepareModels(for: fetchResult)
            output?.didChangeContetnt(user: user)
        }
    }
}
