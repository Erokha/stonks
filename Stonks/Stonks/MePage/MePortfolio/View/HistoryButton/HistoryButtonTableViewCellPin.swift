import Foundation

import UIKit

final class HistoryButtonTableViewCell: UITableViewCell {
    static let identifier = "historyCell"

    let historyView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        return view
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DMSans-Bold", size: 17)
        label.text = "History"
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        configureButton()
        checkTheme()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        checkTheme()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupButtonLayout()
        setupLabelLayout()
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            contentView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            historyView.layer.shadowColor = UIColor.black.cgColor
        } else {
            contentView.backgroundColor = .white
            historyView.layer.shadowColor = UIColor.gray.cgColor
        }
    }

    private func setupButtonLayout() {
        historyView.pin
            .top(20)
            .bottom(20)
            .right(35)
            .left(35)
    }

    private func setupLabelLayout() {
        historyView.addSubview(titleLabel)
        titleLabel.pin
            .hCenter()
            .vCenter()
            .width(100)
            .sizeToFit(.width)
    }

    private func setupCell() {
        contentView.addSubview(historyView)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    private func configureButton() {
        historyView.layer.cornerRadius = CGFloat(Constants.viewRadius)
        historyView.layer.shadowRadius = CGFloat(Constants.shadowRadius)
        historyView.layer.shadowOffset = .init(width: 0, height: 3)
        historyView.layer.shadowOpacity = Float(Constants.shadowOpacity)
    }
}

extension HistoryButtonTableViewCell {
    private struct Constants {
        static let buttonText: String = "History"
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
    }
}
