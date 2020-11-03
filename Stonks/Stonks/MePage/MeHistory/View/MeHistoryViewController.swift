import UIKit

final class MeHistoryViewController: UIViewController {
    var output: MeHistoryOutput?

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        output?.didLoadView()
    }

    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.delegate = self
        tableView.dataSource = self
        let chartNib = UINib(nibName: MeHistoryTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: MeHistoryTableViewCell.reuseIdentifier)
    }

    @IBAction private func didBackActionTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

}

extension MeHistoryViewController: MeHistoryInput {
    func reloadTable() {
        tableView.reloadData()
    }

}
