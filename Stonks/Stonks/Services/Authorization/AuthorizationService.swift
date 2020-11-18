import Foundation

class AuthorizationService {
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

    func authorize() {
        UserDefaults.standard.setValue(true, forKey: Constants.authKey)
    }
    
    func deAuthorize() {
        UserDefaults.standard.setValue(false, forKey: Constants.authKey)
    }
}

extension AuthorizationService {
    private struct Constants {
        static var authKey: String = "isAuthorized"
    }
}
