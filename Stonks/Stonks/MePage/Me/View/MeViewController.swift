import Foundation
import UIKit
import PinLayout

final class MeViewController: UIViewController {
    var presenter: MeOutput!

    private weak var pageViewController: MePageViewController!

    private let pickerController: UIImagePickerController = UIImagePickerController()

    // MARK: Creating UI elements
    private weak var headerViewPin: UIView!

    private weak var nameLabel: UILabel!

    private weak var photoButton: UIButton!

    private weak var cardView: NewCardView!

    private weak var segmentControl: UISegmentedControl!

    private weak var tableContainer: UIView!

    // MARK: VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        pageViewController.mePageDelegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupLayout()
        checkTheme()
    }

    private func setupViews() {
        setupHeaderView()
        setupNameLabel()
        setupPhotoButton()
        setupCardView()
        setupSegemntControl()
        setupTableContainer()
        setupPageViewController()
    }

    private func setupLayout() {
        setupHeaderViewLayout()
        setupSegmentControlLayout()
        setupTableContainerLayout()
        presenter.didLoadView()
        setupImagePicker()
        setupNameLabelLayout()
        setupImageViewLayout()
        setupCardViewLayout()
        setupPageVcLayout()
    }

    private func checkTheme() {
        if self.traitCollection.userInterfaceStyle == .dark {
            headerViewPin.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
            cardView.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            view.backgroundColor = #colorLiteral(red: 0.2414406538, green: 0.2300785482, blue: 0.2739907503, alpha: 1)
            segmentControl.selectedSegmentTintColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
            cardView.layer.shadowColor = UIColor.black.cgColor
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        } else {
            headerViewPin.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
            cardView.backgroundColor = .white
            view.backgroundColor = .white
            cardView.layer.shadowColor = UIColor.gray.cgColor
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            segmentControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
        }
    }

    // MARK: Setupviews

    private func setupHeaderView() {
        let head = UIView()
        headerViewPin = head
        headerViewPin.backgroundColor = #colorLiteral(red: 0.4431372549, green: 0.3960784314, blue: 0.8901960784, alpha: 1)
        headerViewPin.layer.shadowRadius = Constants.shadowRadius
        headerViewPin.layer.shadowOpacity = Constants.shadowOpacity
        headerViewPin.layer.cornerRadius = Constants.headerRadius
        headerViewPin.layer.shadowOffset = .init(width: 0, height: 2)
        view.addSubview(headerViewPin)
    }

    private func setupNameLabel() {
        let label = UILabel()
        nameLabel = label
        nameLabel.font = UIFont(name: "DMSans-Bold", size: 33)
        nameLabel.textColor = Constants.whiteThemeFont
        headerViewPin.addSubview(nameLabel)
    }

    private func setupPhotoButton() {
        let button = UIButton()
        photoButton = button
        photoButton.setImage(UIImage(named: "upload"), for: .normal)
        photoButton.addTarget(self, action: #selector(addImageAction(_:)), for: .touchUpInside)
        headerViewPin.addSubview(photoButton)
    }

    private func setupCardView() {
        let card = CardViewContainer.assemble(with: CardViewContext()).view
        cardView = card
        cardView.layer.shadowOpacity = Constants.shadowOpacity
        cardView.layer.shadowRadius = Constants.cardShadowRadius
        cardView.layer.shadowOffset = .init(width: 0, height: 3)
        cardView.layer.cornerRadius = 20
        cardView.showUpperTextLeft(text: "Avaiable Balance")
        cardView.showUpperTextRight(text: "Total invested")
        headerViewPin.addSubview(cardView)
    }

    private func setupSegemntControl() {
        let segment = UISegmentedControl(items: ["Portfolio", "Settings"])
        segmentControl = segment
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(didIndexChanged(_:)), for: .valueChanged)
        self.view.addSubview(segmentControl)
    }

    private func setupTableContainer() {
        let table = UIView()
        tableContainer = table
        self.view.addSubview(tableContainer)
    }

    private func setupPageViewController() {
        let pageVc = MePageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController = pageVc
        tableContainer.addSubview(pageViewController.view)
    }
    // MARK: Autolayout

    private func setupHeaderViewLayout() {
        headerViewPin.pin.top()
            .left()
            .right()
            .height(25%)
    }

    private func setupNameLabelLayout() {
        nameLabel.pin
            .top(view.pin.safeArea.top)
            .left(8)
            .right(10)
            .height(55)
            .sizeToFit(.width)
    }

    private func setupImageViewLayout() {
        photoButton.pin
            .top(view.pin.safeArea.top + 4)
            .right(8)
            .height(45)
            .width(45)
    }

    private func setupCardViewLayout() {
        cardView.pin
            .bottom(5%)
            .hCenter()
            .height(40%)
            .width(88%)
    }

    private func setupSegmentControlLayout() {
        segmentControl.pin
            .below(of: headerViewPin)
            .hCenter()
            .marginTop(1%)
            .width(95%)
    }

    private func setupPageVcLayout() {
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.pin
            .all()
    }

    private func setupTableContainerLayout() {
        tableContainer.pin
            .below(of: segmentControl)
            .marginTop(1%)
            .width(100%)
            .bottom(view.pin.safeArea.bottom)
    }

    private func setupImagePicker() {
        pickerController.delegate = self
        pickerController.allowsEditing = true
    }

    // MARK: Actions
    @objc private func didIndexChanged(_ sender: UISegmentedControl) {
        presenter.didIndexChanged(index: segmentControl.selectedSegmentIndex)
    }

    @objc private func addImageAction(_ sender: Any) {
        chooseHowToPickImage()
    }
}

extension MeViewController: MeInput {
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }

    func setPage(with page: MePage) {
        pageViewController.setPage(for: page)
    }

    func setUserData(name: String, lastname: String, image: UIImage?) {
        nameLabel.text = name + " " + lastname
        if let img = image {
            photoButton.setImage(img, for: .normal)
            photoButton.imageView?.layer.cornerRadius = Constants.imageCornerRadius
        }
    }

    func setUserSpentInfo(spent: Int) {
        cardView.showNumberRight(num: spent)
    }

    func setUserCurrentBalance(currentBalance: Int) {
        cardView.showNumberLeft(num: currentBalance)
    }
}

// MARK: PageViewController
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

// MARK: Image picker
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

extension MeViewController {
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
