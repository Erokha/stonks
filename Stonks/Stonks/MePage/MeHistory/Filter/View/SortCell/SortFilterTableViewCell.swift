import Foundation
import UIKit
import PinLayout

enum SortBy {
    case increasePrice
    case descendingPrice
    case increaseDate
    case descendingDate
}

protocol SortByDelegate: class {
    func didChangeSortBy(sortBy: SortBy)
}

final class SortFilterTableViewCell: UITableViewCell {
    static let identifier = "SortCell"
    weak var sortByDelegate: SortByDelegate?
    private var currentSortBy: SortBy = .descendingDate
    private var defaultButtonColor: UIColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)

    private let increasePriceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Price low to high", for: .normal)
        button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        return button
    }()

    private let descendingPriceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Price high to low", for: .normal)
        button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        return button
    }()

    private let increaseDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("First old", for: .normal)
        button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        return button
    }()

    private let descendingDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("First new", for: .normal)
        button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkTheme()
        setupCell()
        contentView.addSubview(increasePriceButton)
        contentView.addSubview(descendingPriceButton)
        contentView.addSubview(increaseDateButton)
        contentView.addSubview(descendingDateButton)
        addTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupIncreasePriceButton()
        setupDescendingPriceButton()
        setupIncreaseDateButton()
        setupDescendingDateButton()
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            defaultButtonColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            contentView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            descendingDateButton.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            increaseDateButton.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            increasePriceButton.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            descendingPriceButton.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            increasePriceButton.layer.shadowColor = UIColor.black.cgColor
            descendingPriceButton.layer.shadowColor = UIColor.black.cgColor
            increaseDateButton.layer.shadowColor = UIColor.black.cgColor
            descendingDateButton.layer.shadowColor = UIColor.black.cgColor
        } else {
            contentView.backgroundColor = .white
            descendingDateButton.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            increaseDateButton.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            increasePriceButton.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            descendingPriceButton.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            increasePriceButton.layer.shadowColor = UIColor.gray.cgColor
            descendingPriceButton.layer.shadowColor = UIColor.gray.cgColor
            increaseDateButton.layer.shadowColor = UIColor.gray.cgColor
            descendingDateButton.layer.shadowColor = UIColor.gray.cgColor
        }
    }

    private func setupIncreasePriceButton() {
        increasePriceButton.pin
            .vCenter(-20%)
            .hCenter(-20%)
            .width(Constants.widthPercent)
            .height(Constants.heigthPercent)
    }

    private func setupDescendingPriceButton() {
        descendingPriceButton.pin
            .vCenter(-20%)
            .hCenter(20%)
            .width(Constants.widthPercent)
            .height(Constants.heigthPercent)
    }

    private func setupIncreaseDateButton() {
        increaseDateButton.pin
            .vCenter(20%)
            .hCenter(-20%)
            .width(Constants.widthPercent)
            .height(Constants.heigthPercent)
    }

    private func setupDescendingDateButton() {
        descendingDateButton.pin
            .vCenter(20%)
            .hCenter(20%)
            .width(Constants.widthPercent)
            .height(Constants.heigthPercent)
    }

    private func setupCell() {
        selectionStyle = UITableViewCell.SelectionStyle.none

        increasePriceButton.layer.cornerRadius = Constants.viewRadius
        descendingPriceButton.layer.cornerRadius = Constants.viewRadius
        increaseDateButton.layer.cornerRadius = Constants.viewRadius
        descendingDateButton.layer.cornerRadius = Constants.viewRadius

        increasePriceButton.layer.shadowRadius = Constants.shadowRadius
        descendingPriceButton.layer.shadowRadius = Constants.shadowRadius
        increaseDateButton.layer.shadowRadius = Constants.shadowRadius
        descendingDateButton.layer.shadowRadius = Constants.shadowRadius

        increasePriceButton.layer.shadowOffset = .init(width: 0, height: 2)
        descendingPriceButton.layer.shadowOffset = .init(width: 0, height: 2)
        increaseDateButton.layer.shadowOffset = .init(width: 0, height: 2)
        descendingDateButton.layer.shadowOffset = .init(width: 0, height: 2)

        increasePriceButton.layer.shadowOpacity = Constants.shadowOpacity
        descendingPriceButton.layer.shadowOpacity = Constants.shadowOpacity
        increaseDateButton.layer.shadowOpacity = Constants.shadowOpacity
        descendingDateButton.layer.shadowOpacity = Constants.shadowOpacity
    }

    private func addTargets() {
        increasePriceButton.addTarget(self, action: #selector(increasePriceDidTap(_:)), for: .touchUpInside)
        descendingPriceButton.addTarget(self, action: #selector(descendingPriceDidTap(_:)), for: .touchUpInside)
        increaseDateButton.addTarget(self, action: #selector(increaseDateDidTap(_:)), for: .touchUpInside)
        descendingDateButton.addTarget(self, action: #selector(descendingDateDidTap(_:)), for: .touchUpInside)
    }
    private func setDefault(_ sortBy: SortBy) {
        switch sortBy {
        case .increasePrice:
            increasePriceButton.backgroundColor = defaultButtonColor
        case .descendingPrice:
            descendingPriceButton.backgroundColor = defaultButtonColor
        case .increaseDate:
            increaseDateButton.backgroundColor = defaultButtonColor
        case .descendingDate:
            descendingDateButton.backgroundColor = defaultButtonColor
        }
    }
    private func setChoosen(_ sortBy: SortBy) {
        switch sortBy {
        case .increasePrice:
            increasePriceButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        case .descendingPrice:
            descendingPriceButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        case .increaseDate:
            increaseDateButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        case .descendingDate:
            descendingDateButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        }
    }

    private func didTap(with sortBy: SortBy) {
        setDefault(currentSortBy)
        currentSortBy = sortBy
        setChoosen(sortBy)
        sortByDelegate?.didChangeSortBy(sortBy: sortBy)
    }

    @objc private func increasePriceDidTap(_ sender: Any) {
        didTap(with: .increasePrice)
    }

    @objc private func increaseDateDidTap(_ sender: Any) {
        didTap(with: .increaseDate)
    }

    @objc private func descendingPriceDidTap(_ sender: Any) {
        didTap(with: .descendingPrice)
    }

    @objc private func descendingDateDidTap(_ sender: Any) {
        didTap(with: .descendingDate)
    }
}

extension SortFilterTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 1
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
        static let imageRadius: CGFloat = 10
        static let heigthPercent: Percent = 28%
        static let widthPercent: Percent = 35%
    }
}
