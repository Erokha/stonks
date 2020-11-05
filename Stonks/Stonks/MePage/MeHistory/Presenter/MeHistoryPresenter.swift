import Foundation

final class MeHistoryPresenter {
    weak var view: MeHistoryInput?
    private var interactor: MeHistoryInteractorInput
    var router: MeHistoryRouterInput?

    private var stocks: [Stock] = []
    init(interactor: MeHistoryInteractorInput) {
        self.interactor = interactor
    }

}

extension MeHistoryPresenter: MeHistoryOutput {
    func didFilterButtonTapped() {
        router?.showFilter()
    }

    func didLoadView() {

    }

    func getNumberOfStocks() -> Int {
        return stocks.count
    }

    func stock(at indexPath: IndexPath) -> Stock? {
        return stocks[indexPath.row]
    }
}

extension MeHistoryPresenter: MeHistoryInteractorOutput {
    func didReceive(stocks: [Stock]) {
        self.stocks = stocks
    }
}
