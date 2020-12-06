import Foundation
import Firebase
import GoogleSignIn

final class LoginInteractor: NSObject {

    weak var output: LoginInteractorOutput?

    var termsAccepted: Bool

    init(termsAccepted: Bool) {
        self.termsAccepted = termsAccepted
        super.init()

        GIDSignIn.sharedInstance()?.delegate = self
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

    func signInWithGoogle() {
        GIDSignIn.sharedInstance()?.signIn()
    }
}

extension LoginInteractor: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }

        guard let authentication = user.authentication else {
            return
        }

        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            debugPrint(authResult?.additionalUserInfo?.profile?["given_name"])
            debugPrint(authResult?.additionalUserInfo?.profile?["family_name"])
            debugPrint(authResult?.additionalUserInfo?.profile?["email"])
            self?.output?.succefullySignInWithGoogle()
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        debugPrint("Suddenly disconnected")
    }
}
