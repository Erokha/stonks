import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet private weak var settingsLabel: UILabel!
    @IBOutlet private weak var buttonView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        buttonView.layer.cornerRadius = SettingsTableViewCell.Constants.viewRadius
        buttonView.layer.shadowColor = UIColor.black.cgColor
        buttonView.layer.shadowRadius = SettingsTableViewCell.Constants.shadowRadius
        buttonView.layer.shadowOffset = .init(width: 0, height: 3)
        buttonView.layer.shadowOpacity = SettingsTableViewCell.Constants.shadowOpacity
    }

    func configureCell(label: String) {
        self.settingsLabel.text = label
    }
}

extension SettingsTableViewCell {
    private struct Constants {
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 2
        static let shadowOpacity: Float = 0.4
        static let legendFormSize: CGFloat = 15
    }
}
