import UIKit
import CoreData

final class MainStocksInteractor: NSObject {
    weak var output: MainStocksInteractorOutput?
    private var userFRC: NSFetchedResultsController<User>?
    // private var stocksFRC: NSFetchedResultsController<Stock>?

    required override init() {
        super.init()
        configureUserFrc()
//        configureStockFrc()
        userFRC?.delegate = self
        // stocksFRC?.delegate = self
    }

    func configureUserFrc() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        userFRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try userFRC?.performFetch()
        } catch {
            fatalError("Error while performing user fetch")
        }
    }

//    func configureStockFrc() {
//        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        stocksFRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)
//
//        do {
//            try stocksFRC?.performFetch()
//        } catch {
//            fatalError("Error while performing stock fetch")
//        }
//    }

    private func handleFetchResult(for fetchResult: [NSFetchRequestResult]) {
//        if let object = fetchResult as? [Stock] {
//            let stocks: [StockData] = object.map({ StockData(with: $0) })
//            self.nonFreshedCoreStocks(with: stocks)
//        } else if let object = fetchResult[0] as? User {
//            self.handleUser(with: object)
//        } else {
//            return
//        }
        if let object = fetchResult[0] as? User {
            self.handleUser(with: object)
        } else {
            return
        }

    }

    private func handleUser(with user: User) {
        output?.didReceive(user: MeUserData(with: user))
    }

//    private func nonFreshedCoreStocks(with stocks: [StockData]) {
//        output?.model = stocks
//        var symbols: [String] = []
//        for stock in stocks {
//            symbols.append(stock.stockSymbol)
//        }
//        self.freshStocks(symbols: symbols)
//    }

//    private func deliverStocks(with stocksRaw: [StockRaw]) {
//        var stocksDict: [String: Float] = [:]
//        for element in stocksRaw {
//            stocksDict[element.stockSymbol] = element.stockPrice
//        }
//        output?.handleFreshStocks(data: stocksDict)
//        //output?.didReciveUpdate(userStockUpdate: stocksDict)
//    }

    private func handleError(with error: Error) {
        switch error.localizedDescription {
        case NetworkErrors.sessionTaskFailed.type:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }
}

extension MainStocksInteractor: MainStocksInteractorInput {
    func loadUser() {
        if let user = UserDataService.shared.getUser() {
            self.handleUser(with: user)
        } else {
            self.handleUser(with: User())
        }
    }

//    func loadStocks() {
//        if let coreStocks = StockDataService.shared.getAllStocks() {
//            let stocks: [StockData] = coreStocks.map({ StockData(with: $0) })
//            self.nonFreshedCoreStocks(with: stocks)
//        } else {
//            self.nonFreshedCoreStocks(with: [])
//        }
//    }
//
//    private func freshStocks(symbols: [String]) {
//        NetworkService.shared.fetchStocksFreshPrice(for: symbols, completion: { [weak self] result in
//            if let error = result.error {
//                self?.handleError(with: error)
//                return
//            }
//
//            guard let stocks = result.data else {
//                return
//            }
//            self?.deliverStocks(with: stocks)
//        })
//    }
}

extension MainStocksInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            handleFetchResult(for: fetchResult)
        }
    }
}

extension MainStocksInteractor {
    private struct Constants {
        static let requestPeriod: TimeInterval = 15
    }
}
