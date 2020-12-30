import UIKit
import PinLayout

class MainStocksViewController: UIViewController {
    private weak var tableContainer: UIView!
    private weak var segmentControl: UISegmentedControl!
    weak var pageViewViewController: StocksPageViewController!
    weak var embeddedViewController: NewCardView!
    var output: MainStocksViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.didLoadView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }

    private func setupUI() {
        self.view.backgroundColor = Constants.backgroundColor
        setupEmbeddedViewController()
        setupSegmentControl()
        setupTableContainer()
        setupPageViewController()
    }

    private func layoutUI() {
        layoutEmbeddedViewController()
        layoutSegmentControl()
        layoutTableContainer()
    }

    @IBAction private func didIndexChanged(_ sender: UISegmentedControl) {
        output?.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }

    private func updateColors() {
        view.backgroundColor = Constants.backgroundColor
        embeddedViewController.backgroundColor = Constants.backgroundColor
        embeddedViewController.layer.shadowColor = Constants.shadowColor
    }
}

extension MainStocksViewController {
    // MARK: EmbeddedViewController
    private func setupEmbeddedViewController() {
        let card = CardViewContainer.assemble(with: CardViewContext()).view
        embeddedViewController = card
        embeddedViewController.layer.shadowOpacity = Constants.cardViewShadow.shadowOpacity
        embeddedViewController.layer.shadowRadius = Constants.cardViewShadow.shadowRadius
        embeddedViewController.layer.shadowOffset = .init(width: 0, height: 3)
        embeddedViewController.layer.cornerRadius = 20
        embeddedViewController.layer.shadowColor = Constants.shadowColor
        embeddedViewController.showUpperTextLeft(text: "Avaiable Balance")
        embeddedViewController.showUpperTextRight(text: "Stocks total")
        embeddedViewController.showNumberRight(num: 0)
        view.addSubview(embeddedViewController)
    }

    private func layoutEmbeddedViewController() {
        embeddedViewController.pin
            .top(view.pin.safeArea.top)
            .left(24)
            .right(24)
            .height(82)
    }

    // MARK: Segment control

    private func setupSegmentControl() {
        let segment = UISegmentedControl(items: ["My Stocks", "All Stocks"])
        segmentControl = segment
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(didIndexChanged(_:)), for: .valueChanged)
        self.view.addSubview(segmentControl)
    }

    private func layoutSegmentControl() {
        segmentControl.pin
            .below(of: embeddedViewController).marginTop(Constants.standartMargin)
            .left(24)
            .right(24)
            .height(31)
    }

    // MARK: TableContainer
    private func setupTableContainer() {
        let table = UIView()
        tableContainer = table
        self.view.addSubview(tableContainer)
    }

    private func layoutTableContainer() {
        tableContainer.pin
            .left()
            .right()
            .bottom()
            .below(of: segmentControl).marginTop(Constants.standartMargin)
    }

    // MARK: PageViewController
    private func setupPageViewController() {
        let pageVc = StocksPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewViewController = pageVc
        tableContainer.addSubview(pageViewViewController.view)
        addChild(pageViewViewController)
        pageViewViewController.didMove(toParent: self)
        pageViewViewController.view.pin
            .all()
        pageViewViewController.stocksPageDelegate = self
        guard let tmp = pageViewViewController.pages.first as? UserStocksViewController else { return }
        tmp.output.delegate = self
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

// extension MainStocksViewController {
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if let vc = segue.destination as? ContainerViewController,
//                        segue.identifier == "EmbedSegue" {
//                self.embeddedViewController = vc
//            } else if let vc = segue.destination as? StocksPageViewController,
//                      segue.identifier == "StockContainerSegue" {
//                self.pageViewViewController = vc
//                self.pageViewViewController.stocksPageDelegate = self
//                guard let tmp = pageViewViewController.pages.first as? UserStocksViewController else { return }
//                tmp.output.delegate = self
//            }
//        }
// }

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

        static let standartMargin: CGFloat = 15

        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 1)
            } else {
                return .white
            }
        }

        static var shadowColor: CGColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor.black.cgColor
            } else {
                return UIColor.gray.cgColor
            }
        }
    }
}

extension MainStocksViewController: UserStocksDelegate {
    func getTotalStocksCount(with num: Int) {
        self.setStocksTotal(num: num)
    }
}
