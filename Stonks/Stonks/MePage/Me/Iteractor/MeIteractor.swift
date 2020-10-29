import Foundation

final class MeIteractor {
    weak var output: MeInteractorOutput?

    private func handleUser(with user: User) {
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
