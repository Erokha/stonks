import UIKit
import PinLayout
import Firebase
import GoogleSignIn

final class LoginViewController: UIViewController {
    var output: LoginViewOutput?

    private weak var welcomeLabel: UILabel!

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

    private func setupWelcomeImageView() {
        let label = UILabel()

        welcomeLabel = label
        view.addSubview(welcomeLabel)

        welcomeLabel.text = Constants.WelcomeLabel.text
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = Constants.WelcomeLabel.font
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

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBoxDescriptionLabel))

        tapRecognizer.numberOfTapsRequired = 1
        checkBoxDescriptionLabel.addGestureRecognizer(tapRecognizer)

        checkBoxDescriptionLabel.isUserInteractionEnabled = true
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

        leftSeparatorView.backgroundColor = Constants.SeparatorView.backgroundColor
    }

    private func setupSignInSeparatorLabel() {
        let label = UILabel()

        signInSeparatorLabel = label
        view.addSubview(signInSeparatorLabel)

        signInSeparatorLabel.textAlignment = .center
        signInSeparatorLabel.text = Constants.SignInSeparatorLabel.text
        signInSeparatorLabel.font = Constants.SignInSeparatorLabel.font
    }

    private func setupRightSeparatorView() {
        let separator = UIView()

        rightSeparatorView = separator
        view.addSubview(rightSeparatorView)

        if traitCollection.userInterfaceStyle == .dark {
            rightSeparatorView.backgroundColor = .white
        } else {
            rightSeparatorView.backgroundColor = .black
        }
    }

    private func setupGoogleSignInButton() {
        let button = UIButton()

        googleSignInButton = button
        view.addSubview(googleSignInButton)

        googleSignInButton.backgroundColor = Constants.GoogleSignInButton.backgroundColor
        googleSignInButton.setTitleColor(Constants.GoogleSignInButton.titleColor, for: .normal)

        googleSignInButton.setTitle(Constants.GoogleSignInButton.title, for: .normal)
        googleSignInButton.titleLabel?.font = Constants.GoogleSignInButton.font
        googleSignInButton.layer.cornerRadius = Constants.GoogleSignInButton.cornerRadius

        googleSignInButton.layer.shadowOffset = Constants.GoogleSignInButton.shadowOffset
        googleSignInButton.layer.shadowRadius = Constants.GoogleSignInButton.shadowRadius
        googleSignInButton.layer.shadowColor = Constants.GoogleSignInButton.shadowColor.cgColor
        googleSignInButton.layer.shadowOpacity = Constants.GoogleSignInButton.shadowOpacity

        let imageView = UIImageView(image: UIImage(named: Constants.GoogleSignInButton.imageName))

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
        setupSignInSeparatorLabel()
        setupRightSeparatorView()
        setupGoogleSignInButton()
    }

    private func setupView() {
        view.backgroundColor = Constants.backgroundColor

        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))

        viewTapRecognizer.numberOfTapsRequired = Constants.TapRecognizer.tapsRequired
        view.addGestureRecognizer(viewTapRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()

        output?.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutWelcomeLabel()
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

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        updateView()
        updateNameTextField()
        updateSurnameTextField()
        updateBalanceTextField()
        updateCheckBoxImageView()
        updateLeftSeparatorView()
        updateRightSeparatorView()
        updateGoogleSignInButton()
    }

    private func updateView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func updateNameTextField() {
        if nameTextField.isEditing {
            nameTextField.backgroundColor = Constants.editingStyleEntriesColor
            nameTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            nameTextField.backgroundColor = Constants.defaultStyleEntriesColor
            nameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }

        nameTextField.attributedPlaceholder = NSAttributedString(string: Constants.NameTextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.textFieldPlaceholderColor])
    }

    private func updateSurnameTextField() {
        if surnameTextField.isEditing {
            surnameTextField.backgroundColor = Constants.editingStyleEntriesColor
            surnameTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            surnameTextField.backgroundColor = Constants.defaultStyleEntriesColor
            surnameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }

        surnameTextField.attributedPlaceholder = NSAttributedString(string: Constants.SurnameTextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.textFieldPlaceholderColor])
    }

    private func updateBalanceTextField() {
        if balanceTextField.isEditing {
            balanceTextField.backgroundColor = Constants.editingStyleEntriesColor
            balanceTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            balanceTextField.backgroundColor = Constants.defaultStyleEntriesColor
            balanceTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }

        balanceTextField.attributedPlaceholder = NSAttributedString(string: Constants.BalanceTextField.placeholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.textFieldPlaceholderColor])
    }

    private func updateCheckBoxImageView() {
        guard let imageName = checkBoxImageView.image?.accessibilityIdentifier,
              imageName != Constants.CheckBoxImageView.checkBoxNotCheckedImageName else {
            return
        }

        checkBoxImageView.image = UIImage(named: Constants.CheckBoxImageView.checkBoxIsCheckedImageName)
        checkBoxImageView.image?.accessibilityIdentifier = Constants.CheckBoxImageView.checkBoxIsCheckedImageName
    }

    private func updateLeftSeparatorView() {
        leftSeparatorView.backgroundColor = Constants.SeparatorView.backgroundColor
    }

    private func updateRightSeparatorView() {
        rightSeparatorView.backgroundColor = Constants.SeparatorView.backgroundColor
    }

    private func updateGoogleSignInButton() {
        googleSignInButton.backgroundColor = Constants.GoogleSignInButton.backgroundColor
        googleSignInButton.setTitleColor(Constants.GoogleSignInButton.titleColor, for: .normal)
    }

    private func layoutWelcomeLabel() {
        welcomeLabel.pin
            .top(Constants.WelcomeLabel.topPercent)
            .hCenter()
            .width(Constants.WelcomeLabel.widthPercent)
            .height(Constants.WelcomeLabel.height)
    }

    private func layoutNameTextField() {
        nameTextField.pin
            .top(welcomeLabel.frame.maxY + Constants.screenHeight * Constants.NameTextField.topSpacingMultiplier)
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
            .top(checkBoxImageView.frame.midY - Constants.CheckBoxDescriptionLabel.heightConstant / 2)
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
            .left(Constants.SeparatorView.sideOffsetPercent)
            .height(Constants.SeparatorView.height)
            .width(Constants.SeparatorView.widthPercent)
    }

    private func layoutSignInSeparatorView() {
        signInSeparatorLabel.pin
            .top(registerButton.frame.maxY + Constants.screenHeight * Constants.SignInSeparatorLabel.topSpacingMultiplier)
            .hCenter()
            .width(Constants.SignInSeparatorLabel.widthPercent)
            .height(Constants.SignInSeparatorLabel.height)
    }

    private func layoutRightSeparatorView() {
        rightSeparatorView.pin
            .top(signInSeparatorLabel.frame.midY)
            .right(Constants.SeparatorView.sideOffsetPercent)
            .height(Constants.SeparatorView.height)
            .width(Constants.SeparatorView.widthPercent)
    }

    private func layoutGoogleSignInButton() {
        googleSignInButton.pin
            .top(signInSeparatorLabel.frame.maxY + Constants.screenHeight * Constants.GoogleSignInButton.topSpacingMultiplier)
            .hCenter()
            .width(Constants.GoogleSignInButton.widthPercent)
            .height(Constants.GoogleSignInButton.height)

        googleLogoImageView.pin
            .left(Constants.GoogleSignInButton.imageLeftPercent)
            .height(googleSignInButton.bounds.height * Constants.GoogleSignInButton.imageScale)
            .width(googleSignInButton.bounds.height * Constants.GoogleSignInButton.imageScale)
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

    @objc
    private func didTapCheckBoxDescriptionLabel() {
        output?.didTapCheckBoxDescriptionLabel()
    }
}

extension LoginViewController: LoginViewInput {
    func setCheckBoxChecked() {
        checkBoxImageView.image = UIImage(named: Constants.CheckBoxImageView.checkBoxIsCheckedImageName)
        checkBoxImageView.image?.accessibilityIdentifier = Constants.CheckBoxImageView.checkBoxIsCheckedImageName
    }

    func setCheckBoxUnchecked() {
        checkBoxImageView.image = UIImage(named: Constants.CheckBoxImageView.checkBoxNotCheckedImageName)
        checkBoxImageView.image?.accessibilityIdentifier = Constants.CheckBoxImageView.checkBoxNotCheckedImageName
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

    func setGoogleSignInPresentingVC() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}
