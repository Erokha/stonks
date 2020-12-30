import Foundation
import UIKit

class AllStocksViewController: UIViewController, UINavigationControllerDelegate {
    private var tableView = UITableView()

    var output: AllStocksViewOutput!
    private let refreshControl = UIRefreshControl()
    private let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        output?.didLoadView()
        view.backgroundColor = Constants.backgroundColor
    }

    private func setupTableView() {
        tableView.register(StockTableViewCell.self, forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.color = .black
        self.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)

            activityIndicatorView.hidesWhenStopped = true

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

    @objc private func refreshData(_ sender: Any) {
            output?.routerHardResetUpdate()
            output?.refreshData()
        }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateColors()
    }

    private func updateColors() {
        view.backgroundColor = Constants.backgroundColor
        tableView.reloadData()
    }

}

extension AllStocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.output?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseIdentifier, for: indexPath) as? StockTableViewCell else {
            return UITableViewCell()
        }
        guard let viewModel = output?.stock(at: indexPath) else { return UITableViewCell() }
        cell.setData(data: viewModel)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let symbol: String = output?.stock(at: indexPath)?.stockSymbol ?? "Unknown"
        output?.didTapOnStock(symbol: symbol)
    }

}

extension AllStocksViewController: AllStocksViewInput {
    func reloadTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func startActivity() {
        activityIndicatorView.startAnimating()
    }
    func endActivity() {
        activityIndicatorView.stopAnimating()
        refreshControl.endRefreshing()
    }
}

extension AllStocksViewController {
    private struct Constants {
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
