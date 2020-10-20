import Foundation

protocol AuthorizationServiceInput {
    func userIsAuthorized() -> Bool
    func authorize()
}

protocol CoreDataServiceInput {
    func createUser(name: String, surname: String, balance: Decimal)
    func getUser() -> User?
}
