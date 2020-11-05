import UIKit

class SortFilterTableViewCell: UITableViewCell {
    @IBOutlet private weak var increasePriceButton: UIButton!
    @IBOutlet private weak var descendingPriceButton: UIButton!
    @IBOutlet private weak var increateDateButton: UIButton!
    @IBOutlet private weak var descendingDateButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
