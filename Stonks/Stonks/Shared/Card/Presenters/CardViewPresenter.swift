import UIKit

class CardViewPresenter: CardViewPresenterType {
    unowned let view: CardViewType

    required init(view: CardViewType) {
        self.view = view
    }

    func setUpperTextLeft(text: String) {
        self.view.showUpperTextLeft(text: text)
    }

    func setUpperTextRight(text: String) {
        self.view.showUpperTextRight(text: text)
    }

    func setNumberLeft(num: Int?) {
        self.view.showNumberLeft(num: num)
    }

    func setNumberRight(num: Int?) {
        self.view.showNumberRight(num: num)
    }

}
