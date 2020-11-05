import Foundation

protocol MeHistoryInput: class {
    func reloadTable()
}

protocol MeHistoryOutput: class {
    func stock(at indexPath: IndexPath) -> Stock?
    func getNumberOfStocks() -> Int
    func didLoadView()
    func didFilterButtonTapped()
}

protocol MeHistoryRouterInput: class {
    func showFilter()
}

protocol MeHistoryInteractorInput: class {
    func loadStocks()
}

protocol MeHistoryInteractorOutput: class {
    func didReceive(stocks: [Stock])
}
