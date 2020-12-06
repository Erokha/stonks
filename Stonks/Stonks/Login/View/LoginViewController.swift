import UIKit
import PinLayout
import Firebase
import GoogleSignIn

final class LoginViewController: UIViewController {
    var output: LoginViewOutput?

    private weak var welcomeImageView: UIImageView!

    private weak var nameTextField: UITextField!

    private weak var surnameTextField: UITextField!

    private weak var balanceTextField: UITextField!

    private weak var checkBoxImageView: UIImageView!

    private weak var checkBoxDescriptionLabel: UILabel!

    private weak var registerButton: UIButton!

    private weak var leftSeparatorView: UIView!

    private weak var signInSeparatorLabel: UILabel!

    private weak var rightSeparatorView: UIView!

    private weak var googleSignInButton: UIButton!

    private weak var googleLogoImageView: UIImageView!

    let tabBar: UIViewController = MainTabBar()

    private func setupWelcomeImageView() {
        let imageView = UIImageView()

        welcomeImageView = imageView
        view.addSubview(welcomeImageView)

        welcomeImageView.image = UIImage(named: Constants.WelcomeImageView.imageName)
    }

    private func setupNameTextField() {
        let textField = UITextField()

        nameTextField = textField
        view.addSubview(nameTextField)

        nameTextField.attributedPlaceholder = NSAttributedString(string: Constants.NameTextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.textFieldPlaceholderColor])

        nameTextField.clipsToBounds = true
        nameTextField.layer.cornerRadius = Constants.textFieldCornerRadius
        nameTextField.layer.borderWidth = Constants.textFieldBorderWidth
        nameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        nameTextField.backgroundColor = Constants.defaultStyleEntriesColor
        nameTextField.font = Constants.textFieldFont

        nameTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                      y: .zero,
                                                      width: Constants.textFieldTextLeftSpacing,
                                                      height: .zero))
        nameTextField.leftViewMode = .always
        nameTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                       y: .zero,
                                                       width: Constants.textFieldTextRightSpacing,
                                                       height: .zero))
        nameTextField.rightViewMode = .unlessEditing

        nameTextField.clearButtonMode = .whileEditing
        nameTextField.autocorrectionType = .no

        nameTextField.addTarget(self, action: #selector(didStartNameEditing), for: .editingDidBegin)
        nameTextField.addTarget(self, action: #selector(didFinishNameEditing), for: .editingDidEnd)
    }

    private func setupSurnameTextField() {
        let textField = UITextField()

        surnameTextField = textField
        view.addSubview(surnameTextField)

        surnameTextField.attributedPlaceholder = NSAttributedString(string: Constants.SurnameTextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.textFieldPlaceholderColor])

        surnameTextField.clipsToBounds = true
        surnameTextField.layer.cornerRadius = Constants.textFieldCornerRadius
        surnameTextField.layer.borderWidth = Constants.textFieldBorderWidth
        surnameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        surnameTextField.backgroundColor = Constants.defaultStyleEntriesColor
        surnameTextField.font = Constants.textFieldFont

        surnameTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                         y: .zero,
                                                         width: Constants.textFieldTextLeftSpacing,
                                                         height: .zero))
        surnameTextField.leftViewMode = .always
        surnameTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                          y: .zero,
                                                          width: Constants.textFieldTextRightSpacing,
                                                          height: .zero))
        surnameTextField.rightViewMode = .unlessEditing

        surnameTextField.clearButtonMode = .whileEditing
        surnameTextField.autocorrectionType = .no

        surnameTextField.addTarget(self, action: #selector(didStartSurnameEditing), for: .editingDidBegin)
        surnameTextField.addTarget(self, action: #selector(didFinishSurnameEditing), for: .editingDidEnd)
    }

    private func setupBalanceTextField() {
        let textField = UITextField()

        balanceTextField = textField
        view.addSubview(balanceTextField)

        balanceTextField.attributedPlaceholder = NSAttributedString(string: Constants.BalanceTextField.placeholderText,
                                                                    attributes: [NSAttributedString.Key.foregroundColor: Constants.textFieldPlaceholderColor])

        balanceTextField.clipsToBounds = true
        balanceTextField.layer.cornerRadius = Constants.textFieldCornerRadius
        balanceTextField.layer.borderWidth = Constants.textFieldBorderWidth
        balanceTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        balanceTextField.backgroundColor = Constants.defaultStyleEntriesColor
        balanceTextField.font = Constants.textFieldFont

        balanceTextField.leftView = UIView(frame: CGRect(x: .zero,
                                                         y: .zero,
                                                         width: Constants.textFieldTextLeftSpacing,
                                                         height: .zero))
        balanceTextField.leftViewMode = .always
        balanceTextField.rightView = UIView(frame: CGRect(x: .zero,
                                                          y: .zero,
                                                          width: Constants.textFieldTextRightSpacing,
                                                          height: .zero))
        balanceTextField.rightViewMode = .unlessEditing

        balanceTextField.clearButtonMode = .whileEditing
        balanceTextField.autocorrectionType = .no

        balanceTextField.addTarget(self, action: #selector(didStartBalanceEditing), for: .editingDidBegin)
        balanceTextField.addTarget(self, action: #selector(didFinishBalanceEditing), for: .editingDidEnd)
    }

    private func setupCheckBoxImageView() {
        let imageView = UIImageView()

        checkBoxImageView = imageView
        view.addSubview(checkBoxImageView)

        checkBoxImageView.image = UIImage(named: Constants.CheckBoxImageView.checkBoxNotCheckedImageName)

        let boxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))

        boxTapRecognizer.numberOfTapsRequired = Constants.CheckBoxImageView.recognizerTapsRequired
        checkBoxImageView.addGestureRecognizer(boxTapRecognizer)
        checkBoxImageView.isUserInteractionEnabled = true
    }

    private func setupCheckBoxDescriptionLabel() {
        let label = UILabel()

        checkBoxDescriptionLabel = label
        view.addSubview(checkBoxDescriptionLabel)

        checkBoxDescriptionLabel.lineBreakMode = .byWordWrapping
        checkBoxDescriptionLabel.font = Constants.CheckBoxDescriptionLabel.font
        checkBoxDescriptionLabel.text = Constants.CheckBoxDescriptionLabel.text
        checkBoxDescriptionLabel.textAlignment = .left
        checkBoxDescriptionLabel.numberOfLines = .zero
    }

    private func setupRegisterButton() {
        let button = UIButton()

        registerButton = button
        view.addSubview(registerButton)

        registerButton.backgroundColor = Constants.RegisterButton.backgroundColor
        registerButton.layer.cornerRadius = Constants.RegisterButton.cornerRadius
        registerButton.layer.shadowOffset = Constants.RegisterButton.shadowOffset
        registerButton.layer.shadowRadius = Constants.RegisterButton.shadowRadius
        registerButton.layer.shadowColor = Constants.RegisterButton.shadowColor.cgColor
        registerButton.layer.shadowOpacity = Constants.RegisterButton.shadowOpacity

        registerButton.titleLabel?.font = Constants.RegisterButton.font
        registerButton.setTitleColor(Constants.RegisterButton.fontColor, for: .normal)
        registerButton.setTitle(Constants.RegisterButton.title, for: .normal)

        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    private func setupLeftSeparatorView() {
        let separator = UIView()

        leftSeparatorView = separator
        view.addSubview(leftSeparatorView)

        leftSeparatorView.backgroundColor = .black
    }

    private func setupSignInSeparatorView() {
        let label = UILabel()

        signInSeparatorLabel = label
        view.addSubview(signInSeparatorLabel)

        signInSeparatorLabel.textAlignment = .center
        signInSeparatorLabel.text = "or"
        signInSeparatorLabel.font = UIFont(name: "DMSans-Bold", size: 14)
    }

    private func setupRightSeparatorView() {
        let separator = UIView()

        rightSeparatorView = separator
        view.addSubview(rightSeparatorView)

        rightSeparatorView.backgroundColor = .black
    }

    private func setupGoogleSignInButton() {
        let button = UIButton()

        googleSignInButton = button
        view.addSubview(googleSignInButton)

        googleSignInButton.backgroundColor = .white

        googleSignInButton.setTitle("Sign Up with Google", for: .normal)
        googleSignInButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 14)
        googleSignInButton.setTitleColor(.black, for: .normal)
        googleSignInButton.layer.cornerRadius = 15
        googleSignInButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        googleSignInButton.layer.shadowRadius = 2
        googleSignInButton.layer.shadowColor = UIColor.black.cgColor
        googleSignInButton.layer.shadowOpacity = 0.4

        let imageView = UIImageView(image: UIImage(named: "google_logo"))

        googleLogoImageView = imageView
        googleSignInButton.addSubview(googleLogoImageView)
        googleLogoImageView.contentMode = .scaleToFill

        googleSignInButton.addTarget(self, action: #selector(didTapGoogleSignInButton), for: .touchUpInside)
    }

    private func setupSubviews() {
        setupWelcomeImageView()
        setupNameTextField()
        setupSurnameTextField()
        setupBalanceTextField()
        setupCheckBoxImageView()
        setupCheckBoxDescriptionLabel()
        setupRegisterButton()
        setupLeftSeparatorView()
        setupSignInSeparatorView()
        setupRightSeparatorView()
        setupGoogleSignInButton()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))

        viewTapRecognizer.numberOfTapsRequired = Constants.TapRecognizer.tapsRequired
        view.addGestureRecognizer(viewTapRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self

        setupView()
        setupSubviews()

        output?.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutWelcomeImageView()
        layoutNameTextField()
        layoutSurnameTextField()
        layoutBalanceTextField()
        layoutCheckBoxImageView()
        layoutCheckBoxDescriptionLabel()
        layoutRegisterButton()
        layoutSignInSeparatorView()
        layoutLeftSeparatorView()
        layoutRightSeparatorView()
        layoutGoogleSignInButton()
    }

    private func layoutWelcomeImageView() {
        welcomeImageView.pin
            .top(Constants.WelcomeImageView.topPercent)
            .hCenter()
            .sizeToFit()
    }

    private func layoutNameTextField() {
        nameTextField.pin
            .top(welcomeImageView.frame.maxY + Constants.screenHeight * Constants.NameTextField.topSpacingMultiplier)
            .hCenter()
            .width(Constants.textFieldWidthPercent)
            .height(Constants.textFieldHeightConstant)
    }

    private func layoutSurnameTextField() {
        surnameTextField.pin
            .top(nameTextField.frame.maxY + Constants.screenHeight * Constants.SurnameTextField.topSpacingMultiplier)
            .hCenter()
            .width(Constants.textFieldWidthPercent)
            .height(Constants.textFieldHeightConstant)
    }

    private func layoutBalanceTextField() {
        balanceTextField.pin
            .top(surnameTextField.frame.maxY + Constants.screenHeight * Constants.BalanceTextField.topSpacingMultiplier)
            .hCenter()
            .width(Constants.textFieldWidthPercent)
            .height(Constants.textFieldHeightConstant)
    }

    private func layoutCheckBoxImageView() {
        checkBoxImageView.pin
            .top(balanceTextField.frame.maxY + Constants.screenHeight * Constants.CheckBoxImageView.topSpacingMultiplier)
            .left(Constants.CheckBoxImageView.leftPercent)
            .sizeToFit()
    }

    private func layoutCheckBoxDescriptionLabel() {
        checkBoxDescriptionLabel.pin
            .top(balanceTextField.frame.maxY + Constants.screenHeight * Constants.CheckBoxDescriptionLabel.topSpacingMultiplier)
            .left(checkBoxImageView.frame.maxX + Constants.screenWidth * Constants.CheckBoxDescriptionLabel.leftSpacingMultiplier)
            .right(Constants.CheckBoxDescriptionLabel.rightPercent)
            .height(Constants.CheckBoxDescriptionLabel.heightConstant)
    }

    private func layoutRegisterButton() {
        registerButton.pin
            .top(checkBoxImageView.frame.maxY + Constants.screenHeight * Constants.RegisterButton.topSpacingMultiplier)
            .hCenter()
            .width(Constants.RegisterButton.widthPercent)
            .height(Constants.RegisterButton.heightConstant)
    }

    private func layoutLeftSeparatorView() {
        leftSeparatorView.pin
            .top(signInSeparatorLabel.frame.midY)
            .left(33%)
            .height(1)
            .width(10%)
    }

    private func layoutSignInSeparatorView() {
        signInSeparatorLabel.pin
            .top(registerButton.frame.maxY + 15)
            .hCenter()
            .width(10%)
            .height(48)
    }

    private func layoutRightSeparatorView() {
        rightSeparatorView.pin
            .top(signInSeparatorLabel.frame.midY)
            .right(33%)
            .height(1)
            .width(10%)
    }

    private func layoutGoogleSignInButton() {
        googleSignInButton.pin
            .top(signInSeparatorLabel.frame.maxY + 10)
            .hCenter()
            .width(80%)
            .height(48)

        googleLogoImageView.pin
            .left(5%)
            .height(googleSignInButton.bounds.height * 0.5)
            .width(googleSignInButton.bounds.height * 0.5)
            .vCenter()
    }

    @objc
    private func didTapView() {
        output?.didTapView()
    }

    @objc
    private func didTapCheckBox() {
        output?.didTapCheckBox()
    }

    @objc
    private func didStartNameEditing() {
        output?.didStartNameEditing()
    }

    @objc
    private func didFinishNameEditing() {
        output?.didFinishNameEditing()
    }

    @objc
    private func didStartSurnameEditing() {
        output?.didStartSurnameEditing()
    }

    @objc
    private func didFinishSurnameEditing() {
        output?.didFinishSurnameEditing()
    }

    @objc
    private func didStartBalanceEditing() {
        output?.didStartBalanceEditing()
    }

    @objc
    private func didFinishBalanceEditing() {
        output?.didFinishBalanceEditing()
    }

    @objc
    private func didTapRegisterButton(_ sender: UIButton) {
        output?.didTapRegisterButton(name: nameTextField.text, surname: surnameTextField.text, balance: balanceTextField.text)
    }

    @objc
    private func didTapGoogleSignInButton() {
        output?.didTapGoogleSignInButton()
    }
}

extension LoginViewController: LoginViewInput {
    func setCheckBoxChecked() {
        checkBoxImageView.image = UIImage(named: Constants.CheckBoxImageView.checkBoxIsCheckedImageName)
    }

    func setCheckBoxUnchecked() {
        checkBoxImageView.image = UIImage(named: Constants.CheckBoxImageView.checkBoxNotCheckedImageName)
    }

    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true)
    }

    func setNameTextField(isEditing: Bool) {
        if isEditing {
            nameTextField.backgroundColor = Constants.editingStyleEntriesColor
            nameTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            nameTextField.backgroundColor = Constants.defaultStyleEntriesColor
            nameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }
    }

    func setSurnameTextField(isEditing: Bool) {
        if isEditing {
            surnameTextField.backgroundColor = Constants.editingStyleEntriesColor
            surnameTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            surnameTextField.backgroundColor = Constants.defaultStyleEntriesColor
            surnameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }
    }

    func setBalanceTextField(isEditing: Bool) {
        if isEditing {
            balanceTextField.backgroundColor = Constants.editingStyleEntriesColor
            balanceTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            balanceTextField.backgroundColor = Constants.defaultStyleEntriesColor
            balanceTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController {
    private struct Constants {
        static let defaultStyleEntriesColor: UIColor = UIColor(red: 250 / 255,
                                                               green: 250 / 255,
                                                               blue: 250 / 255,
                                                               alpha: 1)

        static let editingStyleEntriesBorderColor: UIColor = UIColor(red: 113 / 255,
                                                                     green: 101 / 255,
                                                                     blue: 227 / 255,
                                                                     alpha: 1)

        static let editingStyleEntriesColor: UIColor = UIColor(red: 113 / 255,
                                                               green: 101 / 255,
                                                               blue: 227 / 255,
                                                               alpha: 0.2)

        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static let screenWidth: CGFloat = UIScreen.main.bounds.width

        static let textFieldFont: UIFont? = UIFont(name: "DMSans-Regular", size: 15)

        static let textFieldCornerRadius: CGFloat = 10

        static let textFieldBorderWidth: CGFloat = 1

        static let textFieldPlaceholderColor: UIColor = .black

        static let textFieldTextLeftSpacing: CGFloat = 10

        static let textFieldTextRightSpacing: CGFloat = 10

        static let textFieldHeightConstant: CGFloat = 48

        static let textFieldWidthPercent: Percent = 90%

        struct WelcomeImageView {
            static let topPercent: Percent = 16.5%

            static let imageName: String = "welcome"
        }

        struct NameTextField {
            static let placeholderText = String(repeating: " ", count: 4) + "Name"

            static let topSpacingMultiplier: CGFloat = 0.098
        }

        struct SurnameTextField {
            static let placeholderText = String(repeating: " ", count: 4) + "Surname"

            static let topSpacingMultiplier: CGFloat = 0.012
        }

        struct BalanceTextField {
            static let placeholderText = String(repeating: " ", count: 4) + "Start Balance"

            static let topSpacingMultiplier: CGFloat = 0.012
        }

        struct CheckBoxDescriptionLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 13)

            static let text: String = "By creating your account you have to agree with our Terms and Conditions"

            static let topSpacingMultiplier: CGFloat = 0.025

            static let leftSpacingMultiplier: CGFloat = 0.05

            static let rightPercent: Percent = 5%

            static let heightConstant: CGFloat = 45
        }

        struct RegisterButton {
            static let cornerRadius: CGFloat = 10

            static let shadowRadius: CGFloat = 2

            static let borderWidth: CGFloat = 1

            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)

            static let shadowColor: UIColor = .black

            static let shadowOpacity: Float = 0.4

            static let backgroundColor: UIColor = UIColor(red: 113 / 255,
                                                          green: 101 / 255,
                                                          blue: 227 / 255,
                                                          alpha: 1)

            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 17)

            static let title: String = "Look through"

            static let fontColor: UIColor = .white

            static let topSpacingMultiplier: CGFloat = 0.05

            static let widthPercent: Percent = 90%

            static let heightConstant: CGFloat = 55
        }

        struct CheckBoxImageView {
            static let checkBoxIsCheckedImageName: String = "checkBoxChecked"

            static let checkBoxNotCheckedImageName: String = "checkBoxNotChecked"

            static let recognizerTapsRequired: Int = 1

            static let topSpacingMultiplier: CGFloat = 0.035

            static let leftPercent: Percent = 5%
        }

        struct TapRecognizer {
            static let tapsRequired: Int = 1
        }
    }
}
