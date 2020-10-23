import UIKit
import Alamofire
import SwiftyJSON

class MyStocksPresenter {
    var model: [Stock]? {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    weak var view: MyStocksViewInput?
    var router: MyStocksRouterInput?

    private func tmpMethod() {
        let url = "http://192.168.31.36:8000/allStocks"
        let request = AF.request(url)
        request.responseJSON { response in
            guard let object = response.value else {
                print("Oh, no!!!")
                return
            }
            print(object)
            let json = JSON(object)
            if let jArray = json.array {
                for i in jArray {
                    let stock = Stock(stockName: i["companyName"].string ?? "None", stockSymbol: i["symbol"].string ?? "None", stockPrice: i["price"].float ?? 0, stockCount: 5, imageUrl: i["image"].string ?? "logo")
                    self.model?.append(stock)
                }
            }
        }
    }
}

extension MyStocksPresenter: MyStocksViewOutput {
    func didLoadView() {
        self.tmpMethod()
    }

    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

    func stock(at indexPath: IndexPath) -> Stock? {
        return self.model?[indexPath.row] ?? nil
    }

    func setBalance(num: Int) {
        self.view?.setAvaliableBalance(balance: num)
    }

    func setStocksTotal(num: Int) {
        self.view?.setStocksTotal(total: num)
    }
}
