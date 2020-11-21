import Foundation
import Charts

protocol MePortfolioInput: class {
    func reloadTable()
}

protocol MePortfolioOutput: class {
    func createChartData() -> PieChartData?
    func didLoadView()
    func didHistoryButtonTapped()
}

protocol MePortfolioRouterInput: class {
    func showHistory()
    func showError(with error: Error)
}

protocol MePortfolioInteractorInput: class {
    func loadStocks()
}

protocol MePortfolioInteractorOutput: class {
    func didLoaded(stocks: [MePortfolioStockData])
    func didReceiveError(with error: Error)
}
