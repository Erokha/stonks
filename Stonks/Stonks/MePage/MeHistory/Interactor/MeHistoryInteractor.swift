import Foundation
import CoreData

final class MeHistoryInteractor: NSObject {
    weak var output: MeHistoryInteractorOutput?
    private var frc: NSFetchedResultsController<StockHistory>?

    override init() {
        super.init()
        configureFrc()
    }
    private func handle(stocks: [StockHistory]) {
        let stocksData: [StockHistoryData] = stocks.map({ StockHistoryData(with: $0) })
        output?.didReceive(newStocks: stocksData)
    }

    func configureFrc() {
        let fetchRequest: NSFetchRequest<StockHistory> = StockHistory.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]

        frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: DataService.shared.getPersistentContainer().viewContext, sectionNameKeyPath: nil, cacheName: nil)

        do {
            try frc?.performFetch()
            frc?.delegate = self
        } catch {
            fatalError("Error while performing fetch")
        }
    }

    private func prepareModels(for fetchResult: [NSFetchRequestResult]) -> [StockHistory]? {
        if let object = fetchResult as? [StockHistory] {
            return object
        } else {
            return nil
        }
    }
}

extension MeHistoryInteractor: MeHistoryInteractorInput {
    func loadImageUrl(for stocks: [String]) {
        NetworkService.shared.fetchStockImageUrl(for: stocks) { (result) in
            if result.error != nil {
                return
            }
            guard let imageUrls = result.data else { return }

            self.output?.didReceiveImage(images: imageUrls)
        }
    }

    func loadStocks() {
        if let stocks = StockHistoryDataService.shared.getStocks(with: nil, sortby: .descendingDate) {
            handle(stocks: stocks)
        }
    }
}

extension MeHistoryInteractor: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let fetchResult = controller.fetchedObjects {
            if let stocks = prepareModels(for: fetchResult) {
                handle(stocks: stocks)
            }
        }
    }
}
