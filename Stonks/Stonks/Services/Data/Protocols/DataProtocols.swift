import Foundation

protocol UserDataServiceInput {
    func createUser(name: String, surname: String, balance: Decimal)
    func getUser() -> User?
    func editUser(user: User)
}

protocol StockDataServiceInput {
    func createStock(name: String,
                     symbol: String,
                     imageURL: URL)
    func getStock(symbol: String) -> Stock?
    func updateStock(symbol: String, stock: Stock)
    func deleteStock(symbol: String)
    func stockIsNew(symbol: String) -> Bool
    func getAllStocks() -> [Stock]?
}

protocol StockHistoryDataServiceInput {
    func createHistoryStock(name: String,
                            symbol: String,
                            price: Double,
                            type: TypeOfAction,
                            imageUrl: URL)
    func getAllStocks() -> [StockHistory]?
    func getStocks(with type: TypeOfAction?, sortby: SortBy?) -> [StockHistory]?
}
