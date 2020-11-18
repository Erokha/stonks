import UIKit

final class MeSettingsInteractor {
    weak var output: MeSettingsInteractorOutput?
}

extension MeSettingsInteractor: MeSettingsInteractorInput {
    func resetData() {
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
