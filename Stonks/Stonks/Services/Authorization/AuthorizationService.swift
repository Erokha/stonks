import Foundation

class AuthorizationService {
    static var shared = AuthorizationService()

    private init() {

    }
}

extension AuthorizationService: AuthorizationServiceInput {
    func userIsAuthorized() -> Bool {
        guard UserDefaults.standard.string(forKey: "name") != nil,
              UserDefaults.standard.string(forKey: "surname") != nil else {
            return false
        }

        return true
    }

    func saveUser(name: String, surname: String) {
        UserDefaults.standard.setValue(name, forKey: "name")
        UserDefaults.standard.setValue(surname, forKey: "surname")
    }

    func getUser() -> (String, String)? {
        guard let name = UserDefaults.standard.string(forKey: "name"),
              let surname = UserDefaults.standard.string(forKey: "surname") else {
            return nil
        }

        return (name, surname)
    }
}
