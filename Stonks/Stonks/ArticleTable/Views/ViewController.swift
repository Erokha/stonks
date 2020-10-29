import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var strangeView: UIView!
    @IBOutlet private weak var talbeViewTitleLabel: UILabel!

    var output: ArticleViewOutput?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        output?.didLoadView()
    }

}

extension ArticleViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        tableView.layer.shadowColor = UIColor.black.cgColor
        tableView.layer.shadowOpacity = 0.6
        tableView.layer.shadowOffset = .zero
        tableView.layer.shadowRadius = 1
        tableView.largeContentTitle = "News"
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.tableHeaderView = UIView(frame: .zero)
        view.sendSubviewToBack(tableView)
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

        cell.load(with: viewModel)
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
    func setTableViewTitle(_ text: String) {
        self.talbeViewTitleLabel.text = text
    }

    func reloadTable() {
        self.tableView.reloadData()
    }

}
