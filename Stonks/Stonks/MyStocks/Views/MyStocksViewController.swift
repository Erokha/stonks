import UIKit

class MyStocksViewController: UIViewController {

    @IBOutlet private weak var viewContainer: UIView!
    @IBOutlet private weak var tableView: UITableView!
    weak var embeddedViewController: ContainerViewController!
    var output: MyStocksViewOutput?
    private let refreshControl = UIRefreshControl()
    private let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.didLoadView()
        configureTalbeView()
        //setupActivityIndicatorView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.color = .black
        self.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)

            view.superview?.addSubview(activityIndicatorView)
            activityIndicatorView.hidesWhenStopped = true

    }

    private func configureTalbeView() {
        setShadow()
        tableView.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    private func setShadow() {
        self.viewContainer.layer.shadowColor = UIColor.black.cgColor
        self.viewContainer.layer.shadowOpacity = 0.6
        self.viewContainer.layer.shadowOffset = .zero
        self.viewContainer.layer.shadowRadius = 10
    }

    @objc private func refreshData(_ sender: Any) {
        output?.refreshData()
    }

}

extension MyStocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.output?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseIdentifier, for: indexPath) as? StockTableViewCell else {
            return UITableViewCell()
        }
        guard let viewModel = output?.stock(at: indexPath) else { return UITableViewCell() }
        cell.setData(data: viewModel)

        return cell

    }

}

extension MyStocksViewController: MyStocksViewInput {
    func reloadTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func setAvaliableBalance(balance: Int) {
        self.embeddedViewController.showNumberLeft(num: balance)
    }

    func setStocksTotal(total: Int) {
        self.embeddedViewController.showNumberRight(num: total)
    }

    func startActivity() {
        activityIndicatorView.startAnimating()
    }
    func endActivity() {
        activityIndicatorView.stopAnimating()
    }

}

extension MyStocksViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? ContainerViewController,
                        segue.identifier == "EmbedSegue" {
                self.embeddedViewController = vc
            }
        }
}
