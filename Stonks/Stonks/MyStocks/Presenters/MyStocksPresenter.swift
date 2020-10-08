import UIKit

class MyStocksPresenter: MyStocksPresenterType {
    var model: [Stock]
    unowned var view: MyStocksViewController!
    
    required init(view: MyStocksViewType, model: [Stock]) {
        self.view = view as? MyStocksViewController
        self.model = model
    }
    
}
