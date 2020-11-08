import Foundation

protocol UserDataServiceInput {
    func createUser(name: String, surname: String, balance: Decimal)
    func getUser() -> User?
    func editUser(user: User)
}

protocol StockDataServiceInput {
    func createStock(name: String,
                     symbol: String,
                     freshPrice: Decimal,
                     imageURL: URL,
                     amount: Int)
    func getStock(with name: String) -> Stock?
    func updateStock(name: String, stock: Stock)
    func deleteStock(name: String)
}
