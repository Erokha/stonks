import Foundation
import Alamofire
import CoreData

final class MePortfolioInteractor: NSObject {
    weak var output: MePortfolioInteractorOutput?
    private var frc: NSFetchedResultsController<Stock>?

    required override init() {
        super.init()
        configureFrc()
    }

    private func configureFrc() {
        let fetchRequest: NSFetchRequest<Stock> = Stock.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "symbol", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try frc?.performFetch()
            frc?.delegate = self
        } catch {
            fatalError("Error while performing fetch")
        }
    }

    private func prepareModels(for fetchResult: [NSFetchRequestResult]) -> [Stock]? {
        if let object = fetchResult as? [Stock] {
            return object
        } else {
            return nil
        }
    }

    private func handleError(with error: Error) {
        switch error.localizedDescription {
        case NetworkErrors.sessionTaskFailed.type:
            output?.didReceiveError(with: AppError.networkError)
        default:
            output?.didReceiveError(with: AppError.undefinedError)
        }
    }

    private func handleStocks(stocks: [Stock]) {
        var stockSymbols: [String] = []

        stocks.forEach({ stock in
            stockSymbols.append(stock.symbol)
        })

        NetworkService.shared.fetchStocksFreshPrice(for: stockSymbols) { [self] result in
            if let error = result.error {
                handleError(with: error)
            }
            guard let prices = result.data  else { return }

            let stocksData: [MePortfolioStockData] = stocks.enumerated().map({ MePortfolioStockData(with: $1, currentPrice: prices[$0].stockPrice) })
            output?.didLoaded(stocks: stocksData)
        }
    }
}

extension MePortfolioInteractor: MePortfolioInteractorInput {
    func loadStocks() {
        if let stocks = StockDataService.shared.getAllStocks() {
            handleStocks(stocks: stocks)
        } else {
            output?.didLoaded(stocks: [])
        }
    }
}

extension MePortfolioInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            if let stocks = prepareModels(for: fetchResult) {
                handleStocks(stocks: stocks)
            }
        }
    }
}
