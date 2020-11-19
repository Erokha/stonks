import Foundation

final class LoginInteractor {

    weak var output: LoginInteractorOutput?

    var termsAccepted: Bool

    init(termsAccepted: Bool) {
        self.termsAccepted = termsAccepted
    }
}

extension LoginInteractor: LoginInteractorInput {
    func toggleTermsState() {
        termsAccepted = !termsAccepted
    }

    func termsAreAccepted() -> Bool {
        return termsAccepted
    }

    func createUser(name: String, surname: String, balance: Decimal) {
        guard termsAccepted else {
            output?.showAlert(with: "Oops!", message: "Terms need to be accepted")
            return
        }

        AuthorizationService.shared.authorize()
        UserDataService.shared.createUser(name: name, surname: surname, balance: balance)

        output?.userSuccesfullyAuthorized()
    }
}
