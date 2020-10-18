import UIKit
import Charts

enum Sections: Int, CaseIterable {
    case chart = 0, historyButton
}

class MePortfolioViewController: UIViewController {
    @IBOutlet private weak var chartView: UIView!
    @IBOutlet private weak var stocksPieChartView: PieChartView!
    @IBOutlet private weak var historyButton: UIButton!
    @IBOutlet private weak var noDataLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    weak var embeddedViewController: MeHeaderViewController!

    var presenter: MePortfolioOutput!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
        configureTableView()
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView(frame: .zero)

        tableView.delegate = self
        tableView.dataSource = self

        let chartNib = UINib(nibName: ChartTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: ChartTableViewCell.reuseIdentifier)
        let historyNib = UINib(nibName: HistoryButtonTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(historyNib, forCellReuseIdentifier: HistoryButtonTableViewCell.reuseIdentifier)
    }
}

extension MePortfolioViewController {
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

extension MePortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MePortfolioViewController.Constants.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Sections(rawValue: indexPath.section) {
        case .chart:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.reuseIdentifier, for: indexPath) as? ChartTableViewCell else {
                return UITableViewCell()
            }
            if let chartData = presenter.createChartData() {
                cell.configureChartView(pieChartData: chartData)
            } else {
                cell.noDataMessage(message: presenter.noDataMessage())
            }
            return cell

        case .historyButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryButtonTableViewCell.reuseIdentifier, for: indexPath) as? HistoryButtonTableViewCell else { return UITableViewCell() }
            return cell
        default:
            fatalError("MePortfolioViewController/cellForRowAtindexPath.Section: \(indexPath.section)\n Row: \(indexPath.row)")
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Sections(rawValue: indexPath.section) {
        case .chart:
            return CGFloat(MePortfolioViewController.Constants.chartCellHeight)
        case .historyButton:
            return CGFloat(MePortfolioViewController.Constants.buttonCellHeigth)
        default:
            return 0
        }
    }
}

extension MePortfolioViewController: MePortfolioInput {

}

extension MePortfolioViewController {
    struct Constants {
        static let numberOfRowsInSection: Int = 1
        static let chartCellHeight: Int = 400
        static let buttonCellHeigth: Int = 95
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
