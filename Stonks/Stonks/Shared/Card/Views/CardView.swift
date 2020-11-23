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
        self.numberLeft.text = String.adoptStonksCardPrice(with: num)
    }

    func showNumberRight(num: Int?) {
        self.numberRight.text = String.adoptStonksCardPrice(with: num)
    }

    override func setupNib() {
        super.setupNib()
        upperTextLeft.font = Constants.upperTextFont
        upperTextRight.font = Constants.upperTextFont
        numberLeft.font = Constants.numbersFont
        numberRight.font = Constants.numbersFont
    }

}

extension CardView {
    private struct Constants {
        static let upperTextFont: UIFont? = UIFont(name: "DMSans-Medium", size: 12)
        static let numbersFont: UIFont? = UIFont(name: "DMSans-Bold", size: 26)
    }
}

extension String {
    static func adoptStonksCardPrice(with num: Int?) -> String {
        guard let number = num else { return "" }
        if number >= 1000000000 {
            let res = String(format: "%.1f", Float(number) / 1000000000)
            return "$\(res)B"
        } else if number >= 1000000 {
            let res = String(format: "%.1f", Float(number) / 1000000)
            return "$\(res)M"
        } else if number >= 100000 {
            let res = String(format: "%.2f", Float(number) / 1000)
            return "$\(res)k"
        } else {
            return "$\(number)"
        }
    }
}
