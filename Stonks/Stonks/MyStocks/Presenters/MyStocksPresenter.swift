import UIKit

class MyStocksPresenter: MyStocksViewOutput {
    var model: [Stock]
    weak var view: MyStocksViewController!
    
    required init(view: MyStocksViewInput, model: [Stock]) {
        self.view = view as? MyStocksViewController
        self.model = model
    }
    
}
