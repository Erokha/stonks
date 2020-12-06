import Foundation
import UIKit
import PinLayout

final class MeViewControllerPin: UIViewController {
    weak var embeddedViewController: MeContainerViewController!
    weak var pageViewViewController: MePageViewController!

    private var headerViewPin: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowRadius = Constants.shadowRadius
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.cornerRadius = Constants.headerRadius
        view.layer.shadowOffset = .init(width: 0, height: 2)
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sasha Zakharov"
        label.font = UIFont(name: "DMSans-Bold", size: 33)
        label.textColor = Constants.whiteThemeFont
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private let photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "upload"), for: .normal)
        return button
    }()

    // HERE WILL BE CARD VIEW!
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = Constants.shadowOpacity
        view.layer.shadowRadius = Constants.cardShadowRadius
        view.layer.shadowOffset = .init(width: 0, height: 3)
        view.layer.cornerRadius = 10
        return view
    }()

    var presenter: MeOutput!
    private let pickerController: UIImagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupHeaderView()

//        presenter.didLoadView()
//        setupImagePicker()
    }

    override func viewDidLayoutSubviews() {
        setupNameLabel()
        setupImageView()
        setupCardView()
    }
    private func setupMainView() {
        self.view.backgroundColor = .white
        self.view.addSubview(headerViewPin)
    }
    private func setupHeaderView() {
        headerViewPin.pin.top(-12)
            .left()
            .right()
            .height(25%)
    }

    private func setupNameLabel() {
        headerViewPin.addSubview(nameLabel)
        nameLabel.pin
            .top(view.pin.safeArea.top)
            .left(8)
            .right(10)
            .height(55)
            .sizeToFit(.height)
    }

    private func setupImageView() {
        headerViewPin.addSubview(photoButton)
        photoButton.pin
            .top(view.pin.safeArea.top + 4)
            .right(8)
            .height(50)
            .width(50)
    }

    private func setupCardView() {
        headerViewPin.addSubview(cardView)
        cardView.pin
            .below(of: [nameLabel, photoButton])
            .hCenter()
            .marginTop(7%)
            .height(35%)
            .width(85%)
    }
    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    @IBAction private func didIndexChanged(_ sender: UISegmentedControl) {
//        presenter.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }

    @IBAction private func addImageAction(_ sender: Any) {
        chooseHowToPickImage()
    }
}

extension MeViewControllerPin {
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

extension MeViewControllerPin: MeInput {
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func setPage(with page: MePage) {
        pageViewViewController.setPage(for: page)
    }

    func setUserData(name: String, lastname: String, image: UIImage?) {
//        nameLabel.text = name + " " + lastname
//        if let img = image {
//            photoButton.setImage(img, for: .normal)
//            photoButton.imageView?.layer.cornerRadius = Constants.imageCornerRadius
//        }
    }

    func setUserSpentInfo(spent: Int) {
        embeddedViewController.setTotalSpent(spent: spent)
    }

    func setUserCurrentBalance(currentBalance: Int) {
        embeddedViewController.setCurrentBalance(currentBalance: currentBalance)
    }
}

extension MeViewControllerPin: MePageViewDelegate {
    func mePageViewControllerDidSet(with page: MePage) {
//        switch page {
//        case .mePortfolio:
//            segmentControl.selectedSegmentIndex = 0
//        case .meSettings:
//            segmentControl.selectedSegmentIndex = 1
//        }
    }
}

extension MeViewControllerPin {
    struct Constants {
        static let headerRadius: CGFloat = 20
        static let viewRadius: CGFloat = 10
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Float = 0.6
        static let legendFormSize: Float = 15
        static let cardShadowRadius: CGFloat = 5
        static let imageCornerRadius: CGFloat = 15
        static let whiteThemeFont: UIColor = .white
    }
}

extension MeViewControllerPin: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
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
