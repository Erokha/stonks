import UIKit
import PinLayout

class ArticleViewController: UIViewController {

    private weak var tableView: UITableView!
    private weak var talbeViewTitleLabel: UILabel!
    private let refreshControl = UIRefreshControl()
    private let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    var output: ArticleViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutUI()
    }
}

extension ArticleViewController {

    private func setupUI() {
        view.backgroundColor = Constants.backgroundColor
        setupTitle()
        setupTableView()
    }

    private func layoutUI() {
        layoutTitle()
        layoutTableView()
    }

    // tmpshit

    private func setupActivityIndicatorView() {
        activityIndicatorView.color = .black
        self.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
            view.superview?.addSubview(activityIndicatorView)
            activityIndicatorView.hidesWhenStopped = true
    }

    // Title

    private func setupTitle() {
        let label = UILabel()
        self.talbeViewTitleLabel = label
        talbeViewTitleLabel.font = Constants.Title.font
        view.addSubview(talbeViewTitleLabel)
    }

    private func layoutTitle() {
        talbeViewTitleLabel.pin
            .sizeToFit()
            .top(33)
            .left(18)
    }

    // table View

    private func setupTableView() {
        let tmpTableView = UITableView()
        self.tableView = tmpTableView
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.layer.shadowColor = Constants.shadowColor
        tableView.layer.shadowOpacity = 0.6
        tableView.layer.shadowOffset = .init(width: 0, height: 3)
        tableView.layer.shadowRadius = 2
        tableView.contentInsetAdjustmentBehavior = .never
        // tableView.tableHeaderView = UIView(frame: .zero)
        view.sendSubviewToBack(tableView)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.clipsToBounds = true
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false

        view.addSubview(tableView)
    }

    private func layoutTableView() {
        if let tabbar = tabBarController?.tabBar {
            tableView.pin
                .below(of: talbeViewTitleLabel).marginTop(20)
                .left(10)
                .right(10)
                .above(of: tabbar)
        } else {
            tableView.pin
                .below(of: talbeViewTitleLabel).marginTop(20)
                .left(10)
                .right(10)
                .bottom()
        }

            // .bottom(tabBarController?.tabBar.pin.top)
    }

    @objc private func refreshData(_ sender: Any) {
        output?.refreshData()
    }
}

extension ArticleViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateViewColor()
        updateTableViewShadowColor()
    }

    private func updateViewColor() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func updateTableViewShadowColor() {
        tableView.layer.shadowColor = Constants.shadowColor
    }
}

extension ArticleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return output?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
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

extension ArticleViewController {
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

        struct Title {
            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 26)
        }
    }
}
