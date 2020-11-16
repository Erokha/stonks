import Foundation
import CoreData

class StockHistoryDataService {
    static let shared = StockHistoryDataService()

    private init() {

    }

    private lazy var persistentContainer = {
        return DataService.shared.getPersistentContainer()
    }()

    private func createPredicate(with type: TypeOfAction?) -> NSPredicate? {
        if let actionType = type {
            let intType = actionType.rawValue
            let predicate = NSPredicate(format: "type == %@", String(intType))
            return predicate
        } else {
            return nil
        }
    }

    private func createSortDiscriptor(sortBy: SortBy?) -> NSSortDescriptor {
        if let sort = sortBy {
            switch sort {
            case .descendingDate:
                return NSSortDescriptor(key: "date", ascending: false)
            case .descendingPrice:
                return NSSortDescriptor(key: "price", ascending: false)
            case .increaseDate:
                return NSSortDescriptor(key: "date", ascending: true)
            case .increasePrice:
                return NSSortDescriptor(key: "price", ascending: true)
            }
        } else {
            return NSSortDescriptor(key: "date", ascending: true)
        }
    }
}

extension StockHistoryDataService {
    func createHistoryStock(name: String,
                            symbol: String,
                            price: Double,
                            type: TypeOfAction,
                            imageUrl: URL) {
        let typeInt = type.rawValue
        let context = persistentContainer.viewContext

        guard let stockHistory = NSEntityDescription.insertNewObject(forEntityName: Entities.stockHistory.rawValue, into: context) as? StockHistory else { return }

        let date = Date()
        stockHistory.name = name
        stockHistory.symbol = symbol
        stockHistory.price = price
        stockHistory.type = Int16(typeInt)
        stockHistory.date = date
        stockHistory.imageURL = NSURL(fileURLWithPath: imageUrl.path)

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

    func getStocks(with type: TypeOfAction?, sortby: SortBy?) -> [StockHistory]? {
        let context = persistentContainer.viewContext
        let stockHistoryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.stockHistory.rawValue)

        if let predicate = createPredicate(with: type) {
            stockHistoryFetchRequest.predicate = predicate
        }

        let sortDescriptor = createSortDiscriptor(sortBy: sortby)
        stockHistoryFetchRequest.sortDescriptors = [sortDescriptor]
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
