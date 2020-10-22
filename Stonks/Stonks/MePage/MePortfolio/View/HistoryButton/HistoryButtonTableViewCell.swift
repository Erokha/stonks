import UIKit

class HistoryButtonTableViewCell: UITableViewCell {
    @IBOutlet private weak var historyButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        configureButton()
    }

    private func setupCell() {
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    private func configureButton() {
        historyButton.setTitle(HistoryButtonTableViewCell.Constants.buttonText, for: .normal)
        historyButton.layer.cornerRadius = CGFloat(HistoryButtonTableViewCell.Constants.viewRadius)
        historyButton.layer.shadowColor = UIColor.black.cgColor
        historyButton.layer.shadowRadius = CGFloat(HistoryButtonTableViewCell.Constants.shadowRadius)
        historyButton.layer.shadowOffset = .zero
        historyButton.layer.shadowOpacity = Float(HistoryButtonTableViewCell.Constants.shadowOpacity)
    }

    @IBAction private func didButtonTapped(_ sender: Any) {
    }
}

extension HistoryButtonTableViewCell {
    private struct Constants {
        static let buttonText: String = "History"
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Float = 0.6
        static let legendFormSize: CGFloat = 15
    }
}
