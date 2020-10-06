import UIKit


class CardView: EmbeddedView, CardViewType {
    var presenter: CardViewType!
    
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
    
    @IBOutlet weak var upperTextLeft: UILabel!
    @IBOutlet weak var upperTextRight: UILabel!
    @IBOutlet weak var numberLeft: UILabel!
    @IBOutlet weak var numberRight: UILabel!
    
    override func setupNib() {
        super.setupNib()
    }
    
}
