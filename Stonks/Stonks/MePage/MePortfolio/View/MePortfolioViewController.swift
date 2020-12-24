import UIKit

enum MePortfolioSections: Int, CaseIterable {
    case chart = 0, historyButton
}

final class MePortfolioViewController: UIViewController {
    private var tableView = UITableView()

    var output: MePortfolioOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        checkTheme()
        setupTableView()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        self.setupTableViewLayout()
    }

    private func setupTableViewLayout() {
        tableView.pin
            .all()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            tableView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
        } else {
            tableView.backgroundColor = .white
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.reuseIdentifier)
        tableView.register(HistoryButtonTableViewCell.self, forCellReuseIdentifier: HistoryButtonTableViewCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.separatorStyle = .none
    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.pin.all()
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
            if let chartData = output.createChartData() {
                cell.configureChartView(pieChartData: chartData)
            } else {
                cell.dataIsNotAvaliable()
            }
            return cell
        case .historyButton:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryButtonTableViewCell.identifier, for: indexPath) as? HistoryButtonTableViewCell else {
                return UITableViewCell()
            }
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
            output.didHistoryButtonTapped()
        default:
            break
        }
    }
}

extension MePortfolioViewController: MePortfolioInput {
    func reloadTable() {
        self.tableView.reloadData()
    }
}

extension MePortfolioViewController {
    struct Constants {
        static let numberOfRowsInSection: Int = 1
        static let chartCellHeight: CGFloat = 400
        static let buttonCellHeigth: CGFloat = 95
    }
}
