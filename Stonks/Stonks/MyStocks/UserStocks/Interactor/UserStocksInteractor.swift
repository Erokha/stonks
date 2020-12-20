import Foundation
import Alamofire
import CoreData

final class UserStocksInteractor: NSObject {
    weak var output: UserStoksInteractorOutput?
    private var frc: NSFetchedResultsController<Stock>?

    required override init() {
        super.init()
        configureFrc()
        frc?.delegate = self
    }

    func configureFrc() {
        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try frc?.performFetch()
        } catch {
            fatalError("Error while performing fetch")
        }
    }

    private func prepareModels(for fetchResult: [NSFetchRequestResult]) -> [StockData] {
        if let object = fetchResult as? [Stock] {
            let stocks: [StockData] = object.map({ StockData(with: $0) })
            return stocks
        } else {
            return []
        }
    }

    private func handleError(with error: Error) {
        switch error.localizedDescription {
        case NetworkErrors.sessionTaskFailed.type:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }

    private func handleStock(with stocksRaw: [StockRaw]) {
        var stocksDict: [String: (Float, String)] = [:]
        for element in stocksRaw {
            stocksDict[element.stockSymbol] = (element.stockPrice, element.imageUrl)
        }
        output?.didReciveUpdate(userStockUpdate: stocksDict)
    }

}

extension UserStocksInteractor: UserStoksInteractorInput {
    func loadStocksFromCoreData() {
        guard let coreStocks = StockDataService.shared.getAllStocks() else { return }
        let stocks: [StockData] = coreStocks.map({ StockData(with: $0) })
        output?.didReciveCoreData(stocks: stocks)
    }

    func loadStoks(symbols: [String]) {
        NetworkService.shared.fetchStocksFreshPrice(for: symbols, completion: { [weak self] result in
            if let error = result.error {
                self?.handleError(with: error)
                return
            }

            guard let stocks = result.data else {
                return
            }
            self?.handleStock(with: stocks)
        })
    }
}

extension UserStocksInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            let stocks = prepareModels(for: fetchResult)
            output?.didReciveCoreData(stocks: stocks)
            // output?.didChangeContetnt(stocks: )
        }
    }
}
