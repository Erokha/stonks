import UIKit
import PinLayout

enum TypeOfAction: Int {
    case bought = 0, sold
}

protocol TypeOfSortDelegate: class {
    func didChangeTypeOfSort(typeOfSort: TypeOfAction?)
}

final class TypeOfSortTableViewCell: UITableViewCell {
    static let identifier = "TypeSort"
    weak var typeOfSortDelegate: TypeOfSortDelegate?
    private var currentTypeOfSort: TypeOfAction?
    private var defaultButtonColor: UIColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)

    private let boughtButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bought", for: .normal)
        button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        return button
    }()

    private let soldButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sold", for: .normal)
        button.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 16)
        button.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        checkTheme()
        setupButtons()
        contentView.addSubview(boughtButton)
        contentView.addSubview(soldButton)
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
        setupSoldButton()
        setupBoughtButton()
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            defaultButtonColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            contentView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            boughtButton.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            soldButton.backgroundColor = #colorLiteral(red: 0.285693109, green: 0.2685953081, blue: 0.3343991339, alpha: 1)
            boughtButton.layer.shadowColor = UIColor.black.cgColor
            soldButton.layer.shadowColor = UIColor.black.cgColor
        } else {
            contentView.backgroundColor = .white
            boughtButton.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            soldButton.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            boughtButton.layer.shadowColor = UIColor.gray.cgColor
            soldButton.layer.shadowColor = UIColor.gray.cgColor
        }
    }

    private func setupSoldButton() {
        soldButton.pin
            .hCenter(20%)
            .vCenter()
            .width(Constants.widthPercent)
            .height(Constants.heigthPercent)
    }

    private func setupBoughtButton() {
        boughtButton.pin
            .hCenter(-20%)
            .vCenter()
            .width(Constants.widthPercent)
            .height(Constants.heigthPercent)
    }

    private func setupButtons() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        soldButton.layer.cornerRadius = Constants.viewRadius
        boughtButton.layer.cornerRadius = Constants.viewRadius

        soldButton.layer.shadowRadius = Constants.shadowRadius
        boughtButton.layer.shadowRadius = Constants.shadowRadius

        soldButton.layer.shadowOffset = .init(width: 0, height: 2)
        boughtButton.layer.shadowOffset = .init(width: 0, height: 2)

        soldButton.layer.shadowOpacity = Constants.shadowOpacity
        boughtButton.layer.shadowOpacity = Constants.shadowOpacity
    }

    private func addTargets() {
        boughtButton.addTarget(self, action: #selector(boughtButton(_:)), for: .touchUpInside)
        soldButton.addTarget(self, action: #selector(soldButton(_:)), for: .touchUpInside)
    }

    private func setDefault(typeOfSort: TypeOfAction?) {
        switch typeOfSort {
        case .bought:
            boughtButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        case .sold:
            soldButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        case .none:
            break
        }
    }

    private func setChoosen(typeOfSort: TypeOfAction?) {
        switch typeOfSort {
        case .bought:
            boughtButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        case .sold:
            soldButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        case .none:
            break
        }
    }

    private func didTap(with typeOfSort: TypeOfAction) {
        setDefault(typeOfSort: currentTypeOfSort)
        currentTypeOfSort = typeOfSort
        setChoosen(typeOfSort: currentTypeOfSort)
        typeOfSortDelegate?.didChangeTypeOfSort(typeOfSort: currentTypeOfSort)
    }

    @objc private func boughtButton(_ sender: Any) {
        didTap(with: .bought)
    }

    @objc private func soldButton(_ sender: Any) {
        didTap(with: .sold)
    }
}

extension TypeOfSortTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 1
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
        static let imageRadius: CGFloat = 10
        static let heigthPercent: Percent = 55%
        static let widthPercent: Percent = 35%
    }
}
