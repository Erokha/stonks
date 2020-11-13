import UIKit
import Charts
import CoreData

class MeViewController: UIViewController {
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    weak var embeddedViewController: MeContainerViewController!
    weak var pageViewViewController: MePageViewController!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tableContainer: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var cardContainer: UIView!
    @IBOutlet private weak var photoButton: UIButton!

    var presenter: MeOutput!
    private let pickerController: UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setShadowContainer()
        configureHeader()
        presenter.didLoadView()
        setupImagePicker()
    }

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }
    private func configureHeader() {
        setRoundedCorners()
        setShadow()
    }

    private func setRoundedCorners() {
        headerView.layer.cornerRadius = Constants.headerRadius
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }

    private func setShadow() {
        headerView.layer.shadowRadius = Constants.shadowRadius
        headerView.layer.shadowOpacity = Constants.shadowOpacity
        headerView.layer.shadowOffset = .init(width: 0, height: 2)
    }
    private func setShadowContainer() {
        cardContainer.layer.shadowColor = UIColor.gray.cgColor
        cardContainer.layer.shadowOpacity = Constants.shadowOpacity
        cardContainer.layer.shadowOffset = .init(width: 0, height: 3)
        cardContainer.layer.shadowRadius = Constants.cardShadowRadius
    }
    @IBAction private func didIndexChanged(_ sender: UISegmentedControl) {
        presenter.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }

    @IBAction private func addImageAction(_ sender: Any) {
        chooseHowToPickImage()
    }
}

extension MeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MeContainerViewController,
                    segue.identifier == "MeContainerSegue" {
            self.embeddedViewController = vc
        } else if let vc = segue.destination as? MePageViewController,
                  segue.identifier == "MeContainerPageSegue" {
            self.pageViewViewController = vc
            self.pageViewViewController.mePageDelegate = self
        }
    }
}

extension MeViewController: MeInput {
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func setPage(with page: MePage) {
        pageViewViewController.setPage(for: page)
    }

    func setUserData(name: String, lastname: String, image: UIImage?) {
        nameLabel.text = name + " " + lastname
        if let img = image {
            photoButton.setImage(img, for: .normal)
            photoButton.imageView?.layer.cornerRadius = Constants.imageCornerRadius
        }
    }

    func setUserSpentInfo(spent: Int) {
        embeddedViewController.setTotalSpent(spent: spent)
    }

    func setUserCurrentBalance(currentBalance: Int) {
        embeddedViewController.setCurrentBalance(currentBalance: currentBalance)
    }
}

extension MeViewController: MePageViewDelegate {
    func mePageViewControllerDidSet(with page: MePage) {
        switch page {
        case .mePortfolio:
            segmentControl.selectedSegmentIndex = 0
        case .meSettings:
            segmentControl.selectedSegmentIndex = 1
        }
    }
}

extension MeViewController {
    struct Constants {
        static let headerRadius: CGFloat = 20
        static let viewRadius: CGFloat = 10
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Float = 0.6
        static let legendFormSize: Float = 15
        static let cardShadowRadius: CGFloat = 5
        static let imageCornerRadius: CGFloat = 15
    }
}

extension MeViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
           return UIAlertAction(title: title, style: .default) { [unowned self] _ in
               pickerController.sourceType = type
               present(self.pickerController, animated: true)
           }
       }

    private func chooseHowToPickImage() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if let action = self.action(for: .camera, title: "Camera") {
                   alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Photo library") {
                   alertController.addAction(action)
        }

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        guard let img = image else {
            return
        }
        presenter.didImageLoaded(image: img)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        pickerController(picker, didSelect: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            pickerController(picker, didSelect: nil)
            return
        }
        pickerController(picker, didSelect: image)
    }
}

extension  NSUIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
