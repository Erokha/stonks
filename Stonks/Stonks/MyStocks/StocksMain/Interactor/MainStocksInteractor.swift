import UIKit
import CoreData

final class MainStocksInteractor: NSObject {
    weak var output: MainStocksInteractorOutput?
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

    private func prepareModels(for fetchResult: [NSFetchRequestResult]) -> User {
        if let object = fetchResult[0] as? User {
            return object
        } else {
            return User()
        }
    }

    private func handleUser(with user: User) {
        output?.didReceive(user: MeUserData(with: user))
    }
}

extension MainStocksInteractor: MainStocksInteractorInput {
    func loadUser() {
        if let user = UserDataService.shared.getUser() {
            self.handleUser(with: user)
        } else {
            self.handleUser(with: User())
        }
    }
}

extension MainStocksInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            let user = prepareModels(for: fetchResult)
            self.handleUser(with: user)
            //output?.didChangeContetnt(user: MeUserData(with: user))
        }
    }
}
