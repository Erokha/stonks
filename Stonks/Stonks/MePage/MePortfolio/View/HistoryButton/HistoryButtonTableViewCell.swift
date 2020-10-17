import UIKit

class HistoryButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var historyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureButton() {
        historyButton.setTitle(HistoryButtonTableViewCell.Constants.buttonText, for: .normal)
        historyButton.layer.cornerRadius = CGFloat(HistoryButtonTableViewCell.Constants.viewRadius)
        historyButton.layer.shadowColor = UIColor.black.cgColor
        historyButton.layer.shadowRadius = CGFloat(HistoryButtonTableViewCell.Constants.shadowRadius)
        historyButton.layer.shadowOffset = .zero
        historyButton.layer.shadowOpacity = Float(HistoryButtonTableViewCell.Constants.shadowOpacity)
    }
    
    @IBAction func didButtonTapped(_ sender: Any) {
        print("Hello")
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension HistoryButtonTableViewCell {
    private struct Constants {
        static let buttonText = "History"
        static let viewRadius = 15
        static let shadowRadius = 5
        static let shadowOpacity = 0.6
        static let legendFormSize = 15
    }
}
