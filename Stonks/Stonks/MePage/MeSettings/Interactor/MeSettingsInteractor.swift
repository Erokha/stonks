import Foundation

class MeSettingsInteractor {
    weak var output: MeSettingsInteractorOutput?
}

extension MeSettingsInteractor: MeSettingsInteractorInput {
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
