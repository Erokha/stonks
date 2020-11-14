import UIKit

enum SortBy {
    case increasePrice
    case descendingPrice
    case increaseDate
    case descendingDate
}

class SortFilterTableViewCell: UITableViewCell {
    @IBOutlet private weak var increasePriceButton: UIButton!
    @IBOutlet private weak var descendingPriceButton: UIButton!
    @IBOutlet private weak var increaseDateButton: UIButton!
    @IBOutlet private weak var descendingDateButton: UIButton!

    private var currentSortBy: SortBy = .increasePrice

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        setupFirstView()
    }

    private func setupFirstView() {
        increasePriceButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
    }
    private func setupCell() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        increasePriceButton.layer.cornerRadius = Constants.viewRadius
        descendingPriceButton.layer.cornerRadius = Constants.viewRadius
        increaseDateButton.layer.cornerRadius = Constants.viewRadius
        descendingDateButton.layer.cornerRadius = Constants.viewRadius

        increasePriceButton.layer.shadowColor = UIColor.gray.cgColor
        descendingPriceButton.layer.shadowColor = UIColor.gray.cgColor
        increaseDateButton.layer.shadowColor = UIColor.gray.cgColor
        descendingDateButton.layer.shadowColor = UIColor.gray.cgColor

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

        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
    }

    private func setDefault(sortBy: SortBy) {
        switch sortBy {
        case .increasePrice:
            increasePriceButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        case .descendingPrice:
            descendingPriceButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        case .increaseDate:
            increaseDateButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        case .descendingDate:
            descendingDateButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        }
    }
    private func setChoosen(sortBy: SortBy) {
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
    @IBAction private func increasePriceDidTap(_ sender: Any) {
        setDefault(sortBy: currentSortBy)
        currentSortBy = .increasePrice
        setChoosen(sortBy: currentSortBy)
    }

    @IBAction private func increaseDateDidTap(_ sender: Any) {
        setDefault(sortBy: currentSortBy)
        currentSortBy = .increaseDate
        setChoosen(sortBy: currentSortBy)
    }

    @IBAction private func descendingPriceDidTap(_ sender: Any) {
        setDefault(sortBy: currentSortBy)
        currentSortBy = .descendingPrice
        setChoosen(sortBy: currentSortBy)
    }

    @IBAction private func descendingDateDidTap(_ sender: Any) {
        setDefault(sortBy: currentSortBy)
        currentSortBy = .descendingDate
        setChoosen(sortBy: currentSortBy)
    }
}

extension SortFilterTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 1
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
        static let imageRadius: CGFloat = 10
    }
}
