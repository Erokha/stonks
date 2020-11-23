import Foundation

protocol UserDataServiceInput {

    func createUser(name: String, surname: String, balance: Decimal)

    func getUser() -> User?

    func editUser(user: User)
}

protocol StockDataServiceInput {

    // Создать сущность Stock, сохраняя ее в CoreData
    func createStock(name: String,
                     symbol: String,
                     totalCost: NSDecimalNumber,
                     amount: NSInteger,
                     priceHistory: [NSDecimalNumber])

    // Получить сущность Stock, находящуюся в CoreData
    func getStock(symbol: String) -> Stock?

    // Обновить сущность Stock, находящуюся в CoreData
    func updateStock(symbol: String, stock: Stock)

    // Удалить сущность Stock, находящуюся в CoreData
    func deleteStock(symbol: String)

    // Проверить - существует ли сущность Stock в CoreData
    func stockIsNew(symbol: String) -> Bool

    // Получить все Stock, лежащие в CoreData
    func getAllStocks() -> [Stock]?
}

protocol StockHistoryDataServiceInput {
    func createHistoryStock(name: String,
                            symbol: String,
                            price: Decimal,
                            type: TypeOfAction)
    func getAllStocks() -> [StockHistory]?
    func getStocks(with type: TypeOfAction?, sortby: SortBy?) -> [StockHistory]?
}
