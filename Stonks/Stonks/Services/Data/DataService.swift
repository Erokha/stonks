import Foundation

class DataService {
    static var shared = DataService()

    private init() {

    }
}

extension DataService: AuthorizationServiceInput {
    func userIsAuthorized() -> Bool {
        guard let isAuthorizedObject = UserDefaults.standard.value(forKeyPath: "isAuthorized") else {
            return false
        }

        guard let isAuthorized = isAuthorizedObject as? Bool else {
            return false
        }

        return isAuthorized
    }

    func authorize() {
        UserDefaults.standard.setValue(true, forKey: "isAuthorized")
    }
}
