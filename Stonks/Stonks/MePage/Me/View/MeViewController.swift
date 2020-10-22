import UIKit
import Charts

class MeViewController: UIViewController {
    @IBOutlet private weak var chartView: UIView!
    @IBOutlet private weak var stocksPieChartView: PieChartView!
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    weak var embeddedViewController: MeHeaderViewController!
    @IBOutlet private weak var tableContainer: UIView!

    var presenter: MeOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
    }

    @IBAction private func didIndexChanged(_ sender: UISegmentedControl) {
        presenter.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }

}

extension MeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MeHeaderViewController,
            segue.identifier == "headerViewSegue" {
            let presenter = MeHeaderPresenter()
            vc.presenter = presenter
            presenter.view = vc
            self.embeddedViewController = vc
        }
    }
}

extension MeViewController: MeInput {
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    func add(asChildViewController viewController: UIViewController) {
        addChild(viewController)
        tableContainer.addSubview(viewController.view)
        viewController.view.frame = tableContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

}

extension  NSUIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
