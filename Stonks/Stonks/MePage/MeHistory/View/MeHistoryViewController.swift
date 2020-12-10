import UIKit
import PinLayout

final class MeHistoryViewController: UIViewController {
    var output: MeHistoryOutput?

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var searchBar: UISearchBar!

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        label.text = "History"
        label.font = UIFont(name: "DMSans-Bold", size: 25)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        output?.didLoadView()
    }

    private func setupHeaderLabel() {
    }
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        let chartNib = UINib(nibName: MeHistoryTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: MeHistoryTableViewCell.reuseIdentifier)
    }

    @IBAction private func didBackActionTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction private func didFilterButtonTapped(_ sender: Any) {
        output?.didFilterButtonTapped()
    }
}

extension MeHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getNumberOfStocks() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeHistoryTableViewCell.reuseIdentifier, for: indexPath) as? MeHistoryTableViewCell else {
            return UITableViewCell()
        }
        guard let stock = output?.stock(at: indexPath) else {
            return UITableViewCell()
        }

        cell.setData(stock: stock)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.rowHeight
    }
}

extension MeHistoryViewController: MeHistoryInput {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension MeHistoryViewController: MeHistoryFilterDelegate {
    func didSortedStocksLoaded(stocks: [StockHistoryData]) {
        output?.didSortedStocksLoaded(stocks: stocks)
    }
}

extension MeHistoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.didUserStartToSearch(search: searchText)
    }
}

extension MeHistoryViewController {
    private struct Constants {
        static let rowHeight: CGFloat = 62
    }
}
