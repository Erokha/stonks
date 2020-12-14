import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var strangeView: UIView!
    @IBOutlet private weak var talbeViewTitleLabel: UILabel!
    private let refreshControl = UIRefreshControl()
    private let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    var output: ArticleViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        output?.didLoadView()
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

}

extension ArticleViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.layer.shadowColor = UIColor.gray.cgColor
        tableView.layer.shadowOpacity = 0.6
        tableView.layer.shadowOffset = .init(width: -1, height: 2)
        tableView.layer.shadowRadius = 2
        tableView.largeContentTitle = "News"
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = UIView(frame: .zero)
        view.sendSubviewToBack(tableView)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }

    @objc private func refreshData(_ sender: Any) {
        output?.refreshData()
    }

}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return output?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell else {
                    return UITableViewCell()
                }
        guard let viewModel = output?.article(at: indexPath) else { return UITableViewCell() }

        cell.load(with: viewModel, output: output)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}

extension ArticleViewController: ArticleViewInput {
    func startActivity() {
        activityIndicatorView.startAnimating()
    }
    func endActivity() {
        activityIndicatorView.stopAnimating()
        refreshControl.endRefreshing()
    }

    func setTableViewTitle(_ text: String) {
        self.talbeViewTitleLabel.text = text
    }

    func reloadTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

}
