import UIKit

class MeHeaderViewController: UIViewController {
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var cardView: UIView!
    weak var statusViewController: StatusViewController!

    var presenter: MeHeaderOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.didLoadView()
        setRoundCorners()
        configureUi()
        setShadow()
    }

    private func setShadow() {
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = MeHeaderViewController.Constants.shadowOpacity
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = MeHeaderViewController.Constants.shadowRadius
    }

    private func setRoundCorners() {
        headerView.layer.cornerRadius = MeHeaderViewController.Constants.headerRadius
        if #available(iOS 11.0, *) {
            self.headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }

    private func configureUi() {
        headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        headerView.layer.shadowRadius = MeHeaderViewController.Constants.shadowRadius
        headerView.layer.shadowOpacity = MeHeaderViewController.Constants.shadowOpacity
        profileImage.layer.cornerRadius = MeHeaderViewController.Constants.viewRadius
    }
}

extension MeHeaderViewController: MeHeaderInput {
    func setUserSpentInfo(spent: Int) {
        self.statusViewController.setTotalSpent(spent: spent)
    }

    func setUserCurrentBalance(currentBalance: Int) {
        self.statusViewController.setCurrentBalance(currentBalance: currentBalance)
    }

    func setUserData(name: String, lastname: String, image: UIImage) {
        self.nameLabel.text = name
        self.lastNameLabel.text = lastname
        self.profileImage.image = image
    }
}

extension MeHeaderViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? StatusViewController,
              segue.identifier == "statusSegue" else { return }
        self.statusViewController = vc
    }
}

extension MeHeaderViewController {
    struct Constants {
        static let headerRadius: CGFloat = 20
        static let viewRadius: CGFloat = 15
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Float = 0.6
        static let legendFormSize: Float = 15
    }
}
