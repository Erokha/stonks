import UIKit

enum Filters: Int, CaseIterable {
    case sortBy = 0
}

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
        return Filters.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Filters(rawValue: indexPath.section) {
        case .sortBy:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortFilterTableViewCell.reuseIdentifier, for: indexPath) as? SortFilterTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Filters(rawValue: indexPath.section) {
        case .sortBy:
            return 138
        default:
            break
        }
        return 1
    }
}
