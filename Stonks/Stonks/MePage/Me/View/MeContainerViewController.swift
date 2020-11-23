import UIKit

final class MeContainerViewController: UIViewController {
    @IBOutlet private var cardView: CardView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }

    private func setupUi() {
        setupLeftSideCard()
        setupRightSideCard()
        setupCorners()
    }

    private func setupLeftSideCard() {
        cardView.showUpperTextLeft(text: MeContainerViewController.Constants.upperTextLeft)

    }

    private func setupRightSideCard() {
        cardView.showUpperTextRight(text: MeContainerViewController.Constants.upperTextRight)
    }

    private func setupCorners() {
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = MeContainerViewController.Constants.cornerRadius
    }

    func setTotalSpent(spent: Int) {
        cardView.showNumberRight(num: spent)
    }

    func setCurrentBalance(currentBalance: Int) {
        cardView.showNumberLeft(num: currentBalance)
    }
}

extension MeContainerViewController {
    struct Constants {
        static let cornerRadius: CGFloat = 20
        static let upperTextLeft: String = "Avaliable Balance"
        static let upperTextRight: String = "Spent"
    }
}
