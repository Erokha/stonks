import UIKit

class HistoryButtonTableViewCell: UITableViewCell {
    @IBOutlet private weak var historyButton: UIView!
    @IBOutlet private weak var buttonText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        configureButton()
    }

    private func setupCell() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    private func configureButton() {
        buttonText.text = HistoryButtonTableViewCell.Constants.buttonText
        historyButton.layer.cornerRadius = CGFloat(HistoryButtonTableViewCell.Constants.viewRadius)
        historyButton.layer.shadowColor = UIColor.gray.cgColor
        historyButton.layer.shadowRadius = CGFloat(HistoryButtonTableViewCell.Constants.shadowRadius)
        historyButton.layer.shadowOffset = .init(width: 0, height: 3)
        historyButton.layer.shadowOpacity = Float(HistoryButtonTableViewCell.Constants.shadowOpacity)
    }

    @IBAction private func didButtonTapped(_ sender: Any) {
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
