import UIKit

class CardView: EmbeddedView, CardViewType {
    @IBOutlet private weak var upperTextLeft: UILabel!
    @IBOutlet private weak var upperTextRight: UILabel!
    @IBOutlet private weak var numberLeft: UILabel!
    @IBOutlet private weak var numberRight: UILabel!

    var presenter: CardViewPresenterType!

    func showUpperTextLeft(text: String) {
        self.upperTextLeft.text = text
    }

    func showUpperTextRight(text: String) {
        self.upperTextRight.text = text
    }

    func showNumberLeft(num: Int?) {
        if let number = num {
            self.numberLeft.text = "$" + String(number)
        } else {
            self.numberLeft.text = ""
        }
    }

    func showNumberRight(num: Int?) {
        if let number = num {
            self.numberRight.text = "$" + String(number)
        } else {
            self.numberRight.text = ""
        }
    }

    override func setupNib() {
        super.setupNib()
    }

}
