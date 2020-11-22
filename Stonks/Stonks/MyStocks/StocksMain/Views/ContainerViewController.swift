import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet private weak var cardView: CardView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        setupLeftSideCard()
        setupRightSideCard()
        setCorners()
    }

    private func setupLeftSideCard() {
        cardView?.showUpperTextLeft(text: "Avaliable balance")
        cardView?.showNumberLeft(num: 0)
    }

    private func setupRightSideCard() {
        cardView?.showUpperTextRight(text: "Stocks total")
        cardView?.showNumberRight(num: 0)
    }

    private func setCorners() {
        self.cardView?.clipsToBounds = true
        self.cardView?.layer.cornerRadius = 20
    }

    func showUpperTextLeft(text: String) {
        self.cardView?.showUpperTextLeft(text: text)
    }

    func showUpperTextRight(text: String) {
        self.cardView?.showUpperTextRight(text: text)
    }

    func showNumberLeft(num: Int?) {
        self.cardView?.showNumberLeft(num: num)
    }

    func showNumberRight(num: Int?) {
        self.cardView?.showNumberRight(num: num)
    }

}
