import Foundation
import FirebaseAuth

final class AuthorizationService {
    static let shared = AuthorizationService()

    private init() {

    }
}

extension AuthorizationService: AuthorizationServiceInput {
    func userIsAuthorized() -> Bool {
        guard let isAuthorizedObject = UserDefaults.standard.value(forKeyPath: Constants.authKey) else {
            return false
        }

        guard let isAuthorized = isAuthorizedObject as? Bool else {
            return false
        }

        return isAuthorized
    }

    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: Constants.newUserKey)
    }

    func setUserIsNotNew() {
        UserDefaults.standard.setValue(true, forKey: Constants.newUserKey)
    }

    func authorize() {
        UserDefaults.standard.setValue(true, forKey: Constants.authKey)
    }

    func deAuthorize() {
        let firebaseAuth = Auth.auth()

        if firebaseAuth.currentUser != nil {
            do {
                try firebaseAuth.signOut()
            } catch {
                debugPrint("Error in sign out")
            }
        }

        UserDefaults.standard.setValue(false, forKey: Constants.authKey)
    }
}

extension AuthorizationService {
    private struct Constants {
        static let authKey: String = "isAuthorized"

        static let newUserKey: String = "isNewUser"
    }
}
