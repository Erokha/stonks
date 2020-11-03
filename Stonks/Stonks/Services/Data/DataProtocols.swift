import Foundation

protocol AuthorizationServiceInput {
    func userIsAuthorized() -> Bool
    func authorize()
}

protocol CoreDataServiceInput {
    func createUser(name: String, surname: String, balance: Decimal)
    func getUser() -> User?
    func editUser(user: User)
    func createStock(name: String, symbol: String, curPrice: Decimal, imageURL: URL, amount: Int)
    func getStock(with name: String) -> Stock?
    func updateStock(name: String, stock: Stock)
}
