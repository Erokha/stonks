import Foundation

protocol AuthorizationServiceInput {
    func userExists(with nickname: String) -> Bool
}

class AuthorizationService {

}

extension AuthorizationService: AuthorizationServiceInput {
    func userExists(with nickname: String) -> Bool {
        return false
    }
}
