import UIKit

enum Filters: Int, CaseIterable {
    case sortBy = 0, typeOfSort
}

class MeHistoryFilterViewController: UIViewController {
    var output: MeHistoryFilterOutput?

    @IBOutlet private weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private var sortBy: SortBy?
    private var typeOfSort: TypeOfAction?

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let chartNib = UINib(nibName: SortFilterTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: SortFilterTableViewCell.reuseIdentifier)
        let typeOfSort = UINib(nibName: TypeOfSortTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(typeOfSort, forCellReuseIdentifier: TypeOfSortTableViewCell.reuseIdentifier)
    }

    @IBAction private func okAction(_ sender: Any) {
        output?.didOkButtonTapped()
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction private func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MeHistoryFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.numberOfRowsInSection
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return Filters.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Filters(rawValue: indexPath.section) {
        case .sortBy:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortFilterTableViewCell.reuseIdentifier, for: indexPath) as? SortFilterTableViewCell else {
                return UITableViewCell()
            }
            cell.sortByDelegate = self
            return cell
        case .typeOfSort:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeOfSortTableViewCell.reuseIdentifier, for: indexPath) as? TypeOfSortTableViewCell else {
                return UITableViewCell()
            }
            cell.typeOfSortDelegate = self
            cell.typeOfSortDelegate = output
            return cell
        default:
            break
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch Filters(rawValue: indexPath.section) {
        case .sortBy:
            return Constants.sortByCellHeight
        case .typeOfSort:
            return Constants.sortTypeCellHeight
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        switch Filters(rawValue: section) {
        case .sortBy:
            view.backgroundColor = .white
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 20, height: 35))
            label.text = Constants.sortByHeaderText
            label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
            label.font = UIFont(name: "DMSans-Bold", size: 20)
            view.addSubview(label)
            return view
        case .typeOfSort:
            view.backgroundColor = .white
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 20, height: 35))
            label.text = Constants.sortTypeHeaderText
            label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
            label.font = UIFont(name: "DMSans-Bold", size: 20)
            view.addSubview(label)
        default:
            break
        }
        return view
    }
}

extension MeHistoryFilterViewController: MeHistoryFilterInput {
}

extension MeHistoryFilterViewController: FilterDelegate {
    func didChangeTypeOfSort(typeOfSort: TypeOfAction) {
        output?.didChangeTypeOfSort(typeOfSort: typeOfSort)
    }

    func didChangeSortBy(sortBy: SortBy) {
        output?.didChangeSortBy(sortBy: sortBy)
    }
}

extension MeHistoryFilterViewController {
    private struct Constants {
        static let numberOfRowsInSection: Int = 1
        static let sortByCellHeight: CGFloat = 138
        static let sortByHeaderText: String = "Sort By"
        static let sortTypeCellHeight: CGFloat = 69
        static let sortTypeHeaderText: String = "Type of action"
    }
}
