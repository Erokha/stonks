import Foundation

import UIKit

enum Filters: Int, CaseIterable {
    case sortBy = 0, typeOfSort
}

protocol MeHistoryFilterDelegate: class {
    func didSortedStocksLoaded(stocks: [StockHistoryData])
}

final class MeHistoryFilterViewController: UIViewController {
    var output: MeHistoryFilterOutput?
    weak var meHistoryFilterDelegate: MeHistoryFilterDelegate?
    private var sortBy: SortBy?
    private var typeOfSort: TypeOfAction?

    // MARK: UI elements
    private let tableView = UITableView()

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        label.text = "Filter"
        label.font = UIFont(name: "DMSans-Bold", size: 25)
        return label
    }()

    private let okButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "done"), for: .normal)
        button.addTarget(self, action: #selector(okAction(_:)), for: .touchUpInside)
        return button
    }()

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "cancel"), for: .normal)
        button.addTarget(self, action: #selector(cancelAction(_:)), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkTheme()
        setupTableView()
        setupMainView()
    }

    private func setupMainView() {
        view.addSubview(tableView)
        view.addSubview(headerLabel)
        view.addSubview(cancelButton)
        view.addSubview(okButton)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SortFilterTableViewCell.self, forCellReuseIdentifier: SortFilterTableViewCell.identifier)
        tableView.register(TypeOfSortTableViewCell.self, forCellReuseIdentifier: TypeOfSortTableViewCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            view.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            tableView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
        } else {
            view.backgroundColor = .white
            tableView.backgroundColor = .white
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeaderView()
        setupCancelButton()
        setupOkButton()
        setupTableLayout()
    }

    private func setupHeaderView() {
        headerLabel.pin
            .hCenter()
            .top(view.pin.safeArea.top)
            .height(40)
            .sizeToFit(.height)
    }

    private func setupCancelButton() {
        cancelButton.pin
            .top(view.pin.safeArea.top + 2)
            .left(view.pin.safeArea.left + 8)
            .height(29)
            .width(29)
    }

    private func setupOkButton() {
        okButton.pin
            .top(view.pin.safeArea.top + 2)
            .right(view.pin.safeArea.left + 8)
            .height(29)
            .width(29)
    }

    private func setupTableLayout() {
        tableView.pin
            .below(of: headerLabel)
            .marginTop(8)
            .right()
            .left()
            .bottom()
    }

    @objc private func okAction(_ sender: Any) {
        output?.didOkButtonTapped()
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func cancelAction(_ sender: Any) {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SortFilterTableViewCell.identifier, for: indexPath) as? SortFilterTableViewCell else {
                    return UITableViewCell()
            }
            cell.sortByDelegate = self
            return cell
        case .typeOfSort:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TypeOfSortTableViewCell.identifier, for: indexPath) as? TypeOfSortTableViewCell else {
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
            let label = UILabel(frame: CGRect(x: 20, y: 0, width: view.frame.width - 20, height: 35))
            label.text = Constants.sortByHeaderText
            label.textColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
            label.font = UIFont(name: "DMSans-Bold", size: 20)
            view.addSubview(label)
            return view
        case .typeOfSort:
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
    func stocksLoaded(stocks: [StockHistoryData]) {
        meHistoryFilterDelegate?.didSortedStocksLoaded(stocks: stocks)
    }
}

extension MeHistoryFilterViewController: FilterDelegate {
    func didChangeTypeOfSort(typeOfSort: TypeOfAction?) {
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
