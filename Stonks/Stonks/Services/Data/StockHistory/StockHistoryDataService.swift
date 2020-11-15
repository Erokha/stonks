import Foundation
import CoreData

class StockHistoryDataService {
    static let shared = StockHistoryDataService()

    private init() {

    }

    private lazy var persistentContainer = {
        return DataService.shared.getPersistentContainer()
    }()
}

extension StockHistoryDataService {
    func createHistoryStock(name: String,
                            symbol: String,
                            price: Double,
                            date: Date,
                            type: TypeOfAction) {
        let typeInt = type.rawValue
        let context = persistentContainer.viewContext

        guard let stockHistory = NSEntityDescription.insertNewObject(forEntityName: Entities.stockHistory.rawValue, into: context) as? StockHistory else { return }

        stockHistory.name = name
        stockHistory.symbol = symbol
        stockHistory.price = price
        stockHistory.type = Int16(typeInt)
        stockHistory.date = date

        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    func getAllStocks() -> [StockHistory]? {
        let context = persistentContainer.viewContext
        let stockHistoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stockHistory.rawValue)

        do {
            let fetchResult = try context.fetch(stockHistoryFetchRequest)

            guard !fetchResult.isEmpty else {
                return nil
            }

            return fetchResult as? [StockHistory]
        } catch {
            return nil
        }
    }

    func getStocks(with type: TypeOfAction) -> [StockHistory]? {
        let intType = Int16(type.rawValue)

        let context = persistentContainer.viewContext
        let stockHistoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stockHistory.rawValue)

        let predicate = NSPredicate(format: "type == %@", String(intType))

        stockHistoryFetchRequest.predicate = predicate

        do {
            let fetchResult = try context.fetch(stockHistoryFetchRequest)

            guard !fetchResult.isEmpty else {
                return nil
            }

            return fetchResult as? [StockHistory]
        } catch {
            return nil
        }
    }
}
