import UIKit
import CoreData

final class MeInteractor: NSObject {
    weak var output: MeInteractorOutput?
    private var frc: NSFetchedResultsController<User>?

    required override init() {
        super.init()
        configureFrc()
    }

    private func configureFrc() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            frc?.delegate = self
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

extension MeInteractor: MeInteractorInput {
    func saveImage(pngData: Data) {
//        guard let user = UserDataService.shared.getUser() else { return }
        guard let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                         in: .userDomainMask).first else { return }
        let newurl = documentURL.appendingPathComponent("avatar.png")
        do {
//            let newurl = user.avatarURL as URL
            if FileManager.default.fileExists(atPath: newurl.path) {
                try FileManager.default.removeItem(atPath: newurl.path)
            }
            try pngData.write(to: newurl, options: .atomic)
            loadUser()
        } catch {
            fatalError("Unable to write image to url")
        }
    }

    func loadUser() {
        guard let user = UserDataService.shared.getUser() else { return }
        handleUser(with: user)
    }
}

extension MeInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            let user = prepareModels(for: fetchResult)
            output?.didChangeContetnt(user: MeUserData(with: user))
        }
    }
}
