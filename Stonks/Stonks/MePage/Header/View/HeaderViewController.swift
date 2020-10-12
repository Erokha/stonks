import UIKit

class HeaderViewController: UIViewController, HeaderViewInput {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoundCorners()
        configureUi()
        setShadow()
    }
    
    private func setShadow() {
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowOpacity = 0.6
        self.cardView.layer.shadowOffset = .zero
        self.cardView.layer.shadowRadius = 10
    }
    
    private func setRoundCorners() {
        self.headerView.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            self.headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    private func configureUi(){
        self.headerView.layer.shadowPath = UIBezierPath(rect: headerView.bounds).cgPath
        self.headerView.layer.shadowRadius = 20
        self.headerView.layer.shadowOpacity = 0.8
        self.profileImage.image = UIImage(named: "ZUEV")
        self.profileImage.layer.cornerRadius = 15
    }
}

extension HeaderViewController: HeaderViewInput {
    
}
