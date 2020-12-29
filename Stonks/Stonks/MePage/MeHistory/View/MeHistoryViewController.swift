import UIKit
import PinLayout

final class MeHistoryViewController: UIViewController {
    var output: MeHistoryOutput?

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        label.text = "History"
        label.font = UIFont(name: "DMSans-Bold", size: 25)
        return label
    }()

    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "previous"), for: .normal)
        button.addTarget(self, action: #selector(didBackActionTapped(_:)), for: .touchUpInside)
        return button
    }()

    private let filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.addTarget(self, action: #selector(didFilterButtonTapped(_:)), for: .touchUpInside)
        return button
    }()

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .default
        searchBar.placeholder = "Search..."
        return searchBar
    }()

    private let tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkTheme()
        setupTableView()
        setupMainView()
        output?.didLoadView()
    }

    private func setupMainView() {
        searchBar.delegate = self
        self.view.addSubview(headerLabel)
        self.view.addSubview(backButton)
        self.view.addSubview(filterButton)
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeaderLabel()
        setupBackButton()
        setupFilterButton()
        setupSearchBar()
        setupTableViewConstaints()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    private func setupHeaderLabel() {
        headerLabel.pin
            .hCenter()
            .top(view.pin.safeArea.top)
            .height(40)
            .sizeToFit(.height)
    }

    private func setupBackButton() {
        backButton.pin
            .top(view.pin.safeArea.top + 2)
            .left(view.pin.safeArea.left)
            .height(29)
            .width(29)
    }

    private func setupFilterButton() {
        filterButton.pin
            .below(of: headerLabel)
            .margin(12)
            .right(view.pin.safeArea.right)
            .height(32)
            .width(32)
    }

    private func setupSearchBar() {
        searchBar.pin
            .below(of: headerLabel)
            .marginTop(10)
            .before(of: filterButton)
            .marginRight(8)
            .left(view.pin.safeArea.left)
            .height(36)
    }

    private func setupTableViewConstaints() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.pin
            .below(of: searchBar)
            .marginTop(8)
            .left()
            .right()
            .bottom()
    }

    private func setupTableView() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorInsetReference = .fromAutomaticInsets
        tableView.register(MeHistoryTableViewCell.self, forCellReuseIdentifier: MeHistoryTableViewCell.identifier)
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            tableView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            tableView.separatorColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        } else {
            view.backgroundColor = .white
            tableView.backgroundColor = .white
        }
    }

    @objc private func didBackActionTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc private func didFilterButtonTapped(_ sender: Any) {
        output?.didFilterButtonTapped()
    }
}

extension MeHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getNumberOfStocks() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeHistoryTableViewCell.identifier, for: indexPath) as? MeHistoryTableViewCell else {
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
        static let cellIdentifier: String = "cellId"
    }
}
