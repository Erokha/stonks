import UIKit

class SettingsTableViewCellPin: UITableViewCell {
    static let identifier = "cellForSettings"

    private let settingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "DMSans-Bold", size: 17)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    private let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(buttonView)
        setupButtonView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        setupViewLayout()
        setupLabelLayout()
    }

    private func setupViewLayout() {
        buttonView.pin
            .top(5)
            .bottom(5)
            .left(20)
            .right(20)
    }

    private func setupLabelLayout() {
        buttonView.addSubview(settingsLabel)
        settingsLabel.pin
            .center()
            .width(300)
            .sizeToFit(.width)
    }
    private func setupButtonView() {
        buttonView.layer.cornerRadius = Constants.viewRadius
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowRadius = Constants.shadowRadius
        buttonView.layer.shadowOffset = .init(width: 0, height: 3)
        buttonView.layer.shadowOpacity = Constants.shadowOpacity
    }

    func configureCell(label: String) {
        self.settingsLabel.text = label
    }
}

extension SettingsTableViewCellPin {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 2
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
    }
}
