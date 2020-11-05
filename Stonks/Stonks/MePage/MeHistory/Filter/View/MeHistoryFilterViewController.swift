import UIKit

class MeHistoryFilterViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let chartNib = UINib(nibName: SortFilterTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: SortFilterTableViewCell.reuseIdentifier)
    }
}

extension MeHistoryFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortFilterTableViewCell.reuseIdentifier, for: indexPath) as? SortFilterTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
