import UIKit

enum MePortfolioSections: Int, CaseIterable {
    case chart = 0, historyButton
}

class MePortfolioViewController: UIViewController {
    private var tableView = UITableView()

    var presenter: MePortfolioOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
        setupTableView()
        setupView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        let chartNib = UINib(nibName: ChartTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: ChartTableViewCell.reuseIdentifier)
        let historyNib = UINib(nibName: HistoryButtonTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(historyNib, forCellReuseIdentifier: HistoryButtonTableViewCell.reuseIdentifier)
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.separatorStyle = .none
    }
}

extension MePortfolioViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MePortfolioSections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MePortfolioViewController.Constants.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MePortfolioSections(rawValue: indexPath.section) {
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
        switch MePortfolioSections(rawValue: indexPath.section) {
        case .chart:
            return MePortfolioViewController.Constants.chartCellHeight
        case .historyButton:
            return MePortfolioViewController.Constants.buttonCellHeigth
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch MePortfolioSections(rawValue: indexPath.section) {
        case .chart:
            break
        case .historyButton:
            presenter.didHistoryButtonTapped()
        default:
            break
        }
    }
}

extension MePortfolioViewController: MePortfolioInput {

}

extension MePortfolioViewController {
    struct Constants {
        static let numberOfRowsInSection: Int = 1
        static let chartCellHeight: CGFloat = 400
        static let buttonCellHeigth: CGFloat = 95
    }
}
