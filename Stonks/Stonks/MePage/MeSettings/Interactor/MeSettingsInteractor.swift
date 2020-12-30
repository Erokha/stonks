import UIKit

final class MeSettingsInteractor {
    weak var output: MeSettingsInteractorOutput?
}

extension MeSettingsInteractor: MeSettingsInteractorInput {
    func resetData() {
        //        guard let user = UserDataService.shared.getUser() else { return }
                guard let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                                 in: .userDomainMask).first else { return }
                let newurl = documentURL.appendingPathComponent("avatar.png")
                do {
        //            let newurl = user.avatarURL as URL
                    if FileManager.default.fileExists(atPath: newurl.path) {
                        try FileManager.default.removeItem(atPath: newurl.path)
                    }
                } catch {
                    fatalError("Unable to write image to url")
                }
        for entity in Entities.allCases {
            DataService.shared.deleteAllData(entity: entity.rawValue)
        }
        output?.didAllEntitiesDeleted()
    }

    func saveChanges(for user: User) {
        UserDataService.shared.editUser(user: user)
    }

    func loadUser() -> User {
        if let user = UserDataService.shared.getUser() {
            return user
        } else {
            return User()
        }
    }
}
