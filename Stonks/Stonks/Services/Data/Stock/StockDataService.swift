import Foundation
import CoreData

class StockDataService {
    static let shared = StockDataService()

    private init() {

    }

    private lazy var persistentContainer = {
        return DataService.shared.getPersistentContainer()
    }()
}

extension StockDataService: StockDataServiceInput {
    func createStock(name: String,
                     symbol: String,
                     freshPrice: Decimal,
                     imageURL: URL,
                     amount: Int = 0) {
        let context = persistentContainer.viewContext

        guard let stock = NSEntityDescription.insertNewObject(forEntityName: Entities.stock.rawValue, into: context) as? Stock else {
            return
        }

        stock.name = name
        stock.symbol = symbol
        stock.freshPrice = NSDecimalNumber(decimal: freshPrice)
        stock.amount = amount
        stock.imageURL = NSURL(fileURLWithPath: imageURL.absoluteString)

        stock.user = UserDataService.shared.getUser()

        do {
            try context.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }

    func getStock(with name: String) -> Stock? {
        let context = persistentContainer.viewContext
        let stockFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stock.rawValue)

        let predicate = NSPredicate(format: "name == %@", name)

        stockFetchRequest.predicate = predicate

        do {
            let fetchResult = try context.fetch(stockFetchRequest)

            guard !fetchResult.isEmpty else {
                return nil
            }

            return fetchResult[0] as? Stock
        } catch {
            print(error)
            return nil
        }
    }

    func updateStock(name: String, stock: Stock) {
        let context = persistentContainer.viewContext
        let stockFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stock.rawValue)

        let predicate = NSPredicate(format: "name == %@", name)

        stockFetchRequest.predicate = predicate

        do {
            var fetchResult = try context.fetch(stockFetchRequest)

            guard !fetchResult.isEmpty else {
                return
            }

            fetchResult[0] = stock

            try context.save()
        } catch {
            print(error)
        }
    }

    func deleteStock(name: String) {
        let context = persistentContainer.viewContext
        let stockFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stock.rawValue)

        let predicate = NSPredicate(format: "name == %@", name)

        stockFetchRequest.predicate = predicate

        do {
            let fetchResult = try context.fetch(stockFetchRequest)

            guard let stocks = fetchResult as? [Stock],
                  let target = stocks.first else {
                return
            }

            context.delete(target)

            try context.save()
        } catch {
            print(error)
        }
    }
}
