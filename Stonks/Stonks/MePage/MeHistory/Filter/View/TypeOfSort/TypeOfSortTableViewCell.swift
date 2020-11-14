//
//  TypeOfSortTableViewCell.swift
//  Stonks
//
//  Created by  Alexandr Zakharov on 14.11.2020.
//

import UIKit

enum TypeOfSort {
    case bought
    case sold
}

protocol TypeOfSortDelegate: class {
    func didChangeTypeOfSort(typeOfSort: TypeOfSort)
}

class TypeOfSortTableViewCell: UITableViewCell {
    @IBOutlet private weak var soldButton: UIButton!
    @IBOutlet private weak var boughtButton: UIButton!

    weak var typeOfSortDelegate: TypeOfSortDelegate?

    private var currentTypeOfSort: TypeOfSort = .bought

    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtons()
        setupFirstCell()
    }

    private func setupButtons() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none

        soldButton.layer.cornerRadius = Constants.viewRadius
        boughtButton.layer.cornerRadius = Constants.viewRadius

        soldButton.layer.shadowColor = UIColor.gray.cgColor
        boughtButton.layer.shadowColor = UIColor.gray.cgColor

        soldButton.layer.shadowRadius = Constants.shadowRadius
        boughtButton.layer.shadowRadius = Constants.shadowRadius

        soldButton.layer.shadowOffset = .init(width: 0, height: 2)
        boughtButton.layer.shadowOffset = .init(width: 0, height: 2)

        soldButton.layer.shadowOpacity = Constants.shadowOpacity
        boughtButton.layer.shadowOpacity = Constants.shadowOpacity

        self.layoutMargins = UIEdgeInsets.zero
        self.preservesSuperviewLayoutMargins = false
    }

    private func setupFirstCell() {
        boughtButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
    }

    private func setDefault(typeOfSort: TypeOfSort) {
        switch typeOfSort {
        case .bought:
            boughtButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        case .sold:
            soldButton.backgroundColor = #colorLiteral(red: 0.3540481031, green: 0.3433421254, blue: 0.4038961232, alpha: 1)
        }
    }

    private func setChoosen(typeOfSort: TypeOfSort) {
        switch typeOfSort {
        case .bought:
            boughtButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        case .sold:
            soldButton.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        }
    }

    @IBAction private func boughtButton(_ sender: Any) {
        setDefault(typeOfSort: currentTypeOfSort)
        currentTypeOfSort = .bought
        setChoosen(typeOfSort: currentTypeOfSort)
        typeOfSortDelegate?.didChangeTypeOfSort(typeOfSort: currentTypeOfSort)
    }

    @IBAction private func soldButton(_ sender: Any) {
        setDefault(typeOfSort: currentTypeOfSort)
        currentTypeOfSort = .sold
        setChoosen(typeOfSort: currentTypeOfSort)
        typeOfSortDelegate?.didChangeTypeOfSort(typeOfSort: currentTypeOfSort)
    }
}

extension TypeOfSortTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 1
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
        static let imageRadius: CGFloat = 10
    }
}
