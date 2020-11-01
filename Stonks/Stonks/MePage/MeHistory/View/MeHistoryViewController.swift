import UIKit

final class MeHistoryViewController: UIViewController {
    var output: MeHistoryOutput?

    @IBOutlet private weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func didBackActionTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MeHistoryViewController: MeHistoryInput {

}
