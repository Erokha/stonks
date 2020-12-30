import UIKit

class MainStocksPresenter {
    var router: MainStocksRouterInput?
    weak var view: MainStocksViewInput?
    private var interactor: MainStocksInteractorInput
    private var shouldUpdateData: Bool

//    var model: [StockData]? {
//        didSet {
//            DispatchQueue.main.async {
//                self.calculateStocksTotal()
//            }
//        }
//    }

    init(interactor: MainStocksInteractorInput) {
        self.interactor = interactor
        shouldUpdateData = false
    }
}

extension MainStocksPresenter: MainStocksViewOutput {
    func didLoadView() {
        shouldUpdateData = true
        // interactor.loadStocks()
        interactor.loadUser()
    }

    func didIndexChanged(index: Int) {
         switch index {
         case 0:
            view?.setPage(with: .allStocks)
         case 1:
             view?.setPage(with: .userStocks)
         default:
             break
         }
     }

//    func calculateStocksTotal() {
//        guard let data = self.model else { return }
//        var totalStocks: Float = 0
//        for stock in data {
//            totalStocks += Float(stock.stockCount) * stock.stockPrice
//        }
//        if shouldUpdateData {
//            //view?.setStocksTotal(num: Int(totalStocks))
//        }
//    }
}

extension MainStocksPresenter: MainStocksInteractorOutput {
    func didReciveError(with error: Error) {
        router?.showError(with: error)
    }

//    func handleFreshStocks(data: [String: Float]) {
//        guard var newmodel = self.model else { return }
//        for i in 0...newmodel.count - 1 {
//            newmodel[i].stockPrice = data[newmodel[i].stockSymbol] ?? 0
//        }
//        self.model = newmodel
//    }

    func didReceive(user: MeUserData) {
        if shouldUpdateData {
            self.view?.setAvaliableBalance(num: user.balance)
        }
    }
}
