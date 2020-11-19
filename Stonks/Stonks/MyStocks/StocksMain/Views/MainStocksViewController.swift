import UIKit

class MainStocksViewController: UIViewController {
    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var tableContainer: UIView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    weak var pageViewViewController: StocksPageViewController!
    weak var embeddedViewController: ContainerViewController!
    var output: MainStocksViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadow()
        output?.didLoadView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    private func setShadow() {
        self.viewContainer.layer.shadowColor =
            Constants.cardViewShadow.shadowColor
        self.viewContainer.layer.shadowOpacity = Constants.cardViewShadow.shadowOpacity
        self.viewContainer.layer.shadowOffset = Constants.cardViewShadow.shadowOffset
        self.viewContainer.layer.shadowRadius = Constants.cardViewShadow.shadowRadius
    }

    @IBAction private func didIndexChanged(_ sender: UISegmentedControl) {
        output?.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }
}

extension MainStocksViewController: MainStocksViewInput {
    func setPage(with page: StocksPage) {
        pageViewViewController.setPage(for: page)
    }

    func setAvaliableBalance(num balance: Int) {
        self.embeddedViewController.showNumberLeft(num: balance)
    }

    func setStocksTotal(num total: Int) {
        self.embeddedViewController.showNumberRight(num: total)
    }

}

extension MainStocksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? ContainerViewController,
                        segue.identifier == "EmbedSegue" {
                self.embeddedViewController = vc
            } else if let vc = segue.destination as? StocksPageViewController,
                      segue.identifier == "StockContainerSegue" {
                self.pageViewViewController = vc
                self.pageViewViewController.stocksPageDelegate = self
            }
        }
}

extension MainStocksViewController: StocksPageViewDelegate {
    func stocksPageViewControllerDidSet(with page: StocksPage) {
        switch page {
        case .allStocks:
            segmentControl.selectedSegmentIndex = 0
        case .userStocks:
            segmentControl.selectedSegmentIndex = 1
        }
    }
}

extension MainStocksViewController {
    private struct Constants {
        struct cardViewShadow {
            static let shadowColor: CGColor = UIColor.black.cgColor
            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
            static let shadowRadius: CGFloat = 3
            static let shadowOpacity: Float = 0.5
        }
    }
}
