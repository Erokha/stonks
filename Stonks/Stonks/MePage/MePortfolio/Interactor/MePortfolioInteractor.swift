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

    private func didStocksChanged(stocks: [Stock]) {
        var stockSymbols: [String] = []

        for stock in stocks {
            print("Stock name:\(stock.symbol) Stock price: \(String(describing: stock.priceHistory.last))")
        }
//        NetworkService.shared.fetchStocksFreshPrice(for: stockSymbols) { [self] result in
//            if let error = result.error {
//                handleError(with: error)
//            }
//            guard let prices = result.data  else { return }
//
//            let stockData: [MePortfolioStockData] = stocks.enumerated().map({ MePortfolioStockData(with: $1, currentPrice: prices[$0].stockPrice) })
//            print("PRICES:", stockData)
//        }
    }

    private func prepareModels(for fetchResult: [NSFetchRequestResult]) -> [Stock]? {
        if let object = fetchResult as? [Stock] {
            return object
        } else {
            return nil
        }
    }

    private func handleError(with error: Error) {
        // DO ERRORS
    }

    private func handleStocks(stocks: [Stock]) {
        var stocksData: [MePortfolioStockData] = []
        for stock in stocks {
            // request to network
            let stockData = MePortfolioStockData(with: stock, currentPrice: Float(Int.random(in: 1...50)))
            stocksData.append(stockData)
        }
        output?.didLoaded(stocks: stocksData)
    }
}

extension MePortfolioInteractor: MePortfolioInteractorInput {
    func loadStocks() {
        guard let stocks = StockDataService.shared.getAllStocks() else { return }
        handleStocks(stocks: stocks)
    }
}

extension MePortfolioInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            if let stocks = prepareModels(for: fetchResult) {
                didStocksChanged(stocks: stocks)
            }
        }
    }
}
