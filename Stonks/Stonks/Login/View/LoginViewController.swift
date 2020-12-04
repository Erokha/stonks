import UIKit
import PinLayout

class LoginViewController: UIViewController {
    var output: LoginViewOutput?

    private weak var welcomeImageView: UIImageView!

    private weak var nameTextField: UITextField!

    private weak var surnameTextField: UITextField!

    private weak var balanceTextField: UITextField!

    private weak var checkBoxImageView: UIImageView!

    private weak var checkBoxDescriptionLabel: UILabel!

    private weak var registerButton: UIButton!

    private func setupWelcomeImageView() {
        let imageView = UIImageView()

        welcomeImageView = imageView
        view.addSubview(welcomeImageView)

        welcomeImageView.image = UIImage(named: "welcome")
    }

    private func setupNameTextField() {
        let textField = UITextField()

        nameTextField = textField
        view.addSubview(nameTextField)

        nameTextField.attributedPlaceholder = NSAttributedString(string: Constants.namePlaceholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.NameTextField.placeholderColor])

        nameTextField.clipsToBounds = Constants.NameTextField.clipsToBounds
        nameTextField.layer.cornerRadius = Constants.NameTextField.cornerRadius
        nameTextField.layer.borderWidth = Constants.NameTextField.borderWidth
        nameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        nameTextField.backgroundColor = Constants.defaultStyleEntriesColor
        nameTextField.font = UIFont(name: "DMSans-Regular", size: 15)
        nameTextField.placeholder = Constants.namePlaceholderText

        nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        nameTextField.leftViewMode = .always
        nameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
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

        surnameTextField.attributedPlaceholder = NSAttributedString(string: Constants.surnamePlaceholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.SurnameTextField.placeholderColor])

        surnameTextField.clipsToBounds = Constants.SurnameTextField.clipsToBounds
        surnameTextField.layer.cornerRadius = Constants.SurnameTextField.cornerRadius
        surnameTextField.layer.borderWidth = Constants.SurnameTextField.borderWidth
        surnameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        surnameTextField.backgroundColor = Constants.defaultStyleEntriesColor
        surnameTextField.font = UIFont(name: "DMSans-Regular", size: 15)
        surnameTextField.placeholder = Constants.surnamePlaceholderText

        surnameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        surnameTextField.leftViewMode = .always
        surnameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
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

        balanceTextField.attributedPlaceholder = NSAttributedString(string: Constants.balancePlaceholderText,
                                                                    attributes: [NSAttributedString.Key.foregroundColor: Constants.BalanceTextField.placeholderColor])

        balanceTextField.clipsToBounds = Constants.BalanceTextField.clipsToBounds
        balanceTextField.layer.cornerRadius = Constants.BalanceTextField.cornerRadius
        balanceTextField.layer.borderWidth = Constants.BalanceTextField.borderWidth
        balanceTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        balanceTextField.backgroundColor = Constants.defaultStyleEntriesColor
        balanceTextField.font = UIFont(name: "DMSans-Regular", size: 15)
        balanceTextField.placeholder = Constants.balancePlaceholderText

        balanceTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        balanceTextField.leftViewMode = .always
        balanceTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
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

        checkBoxImageView.image = UIImage(named: "checkBoxNotChecked")

        let boxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))

        boxTapRecognizer.numberOfTapsRequired = Constants.CheckBoxImageView.recognizerTapsRequired
        checkBoxImageView.addGestureRecognizer(boxTapRecognizer)
        checkBoxImageView.isUserInteractionEnabled = Constants.CheckBoxImageView.isUserInteractionEnabled
    }

    private func setupCheckBoxDescriptionLabel() {
        let label = UILabel()

        checkBoxDescriptionLabel = label
        view.addSubview(checkBoxDescriptionLabel)

        checkBoxDescriptionLabel.lineBreakMode = .byWordWrapping
        checkBoxDescriptionLabel.font = UIFont(name: "DMSans-Regular", size: 13)
        checkBoxDescriptionLabel.text = "By creating your account you have to agree with our Terms and Conditions"
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
        registerButton.layer.shadowRadius = Constants.RegisterButton.cornerRadius
        registerButton.layer.shadowColor = Constants.RegisterButton.shadowColor.cgColor
        registerButton.layer.shadowOpacity = Constants.RegisterButton.shadowOpacity

        registerButton.titleLabel?.font = UIFont(name: "DMSans-Bold", size: 17)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.setTitle("Register my account", for: .normal)

        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    private func setupSubviews() {
        setupWelcomeImageView()
        setupNameTextField()
        setupSurnameTextField()
        setupBalanceTextField()
        setupCheckBoxImageView()
        setupCheckBoxDescriptionLabel()
        setupRegisterButton()
    }

    private func setupView() {
        view.backgroundColor = .white

        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))

        viewTapRecognizer.numberOfTapsRequired = Constants.TapRecognizer.tapsRequired
        view.addGestureRecognizer(viewTapRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupView()

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
    }

    private func layoutWelcomeImageView() {
        welcomeImageView.pin
            .top(16.5%)
            .hCenter()
            .sizeToFit()
    }

    private func layoutNameTextField() {
        nameTextField.pin
            .top(welcomeImageView.frame.maxY + UIScreen.main.bounds.height * 0.098)
            .hCenter()
            .width(90%)
            .height(48)
    }

    private func layoutSurnameTextField() {
        surnameTextField.pin
            .top(nameTextField.frame.maxY + UIScreen.main.bounds.height * 0.012)
            .hCenter()
            .width(90%)
            .height(48)
    }

    private func layoutBalanceTextField() {
        balanceTextField.pin
            .top(surnameTextField.frame.maxY + UIScreen.main.bounds.height * 0.012)
            .hCenter()
            .width(90%)
            .height(48)
    }

    private func layoutCheckBoxImageView() {
        checkBoxImageView.pin
            .top(balanceTextField.frame.maxY + UIScreen.main.bounds.height * 0.035)
            .left(5%)
            .sizeToFit()
    }

    private func layoutCheckBoxDescriptionLabel() {
        checkBoxDescriptionLabel.pin
            .top(balanceTextField.frame.maxY + UIScreen.main.bounds.height * 0.025)
            .left(checkBoxImageView.frame.maxX + UIScreen.main.bounds.width * 0.05)
            .right(5%)
            .height(45)
    }

    private func layoutRegisterButton() {
        registerButton.pin
            .top(checkBoxImageView.frame.maxY + UIScreen.main.bounds.height * 0.05)
            .hCenter()
            .width(90%)
            .height(55)
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

    @IBAction private func didTapRegisterButton(_ sender: UIButton) {
        output?.didTapRegisterButton(name: nameTextField.text, surname: surnameTextField.text, balance: balanceTextField.text)
    }
}

extension LoginViewController: LoginViewInput {
    func setCheckBoxChecked() {
        checkBoxImageView.image = UIImage(named: Constants.checkBoxIsCheckedImageName)
    }

    func setCheckBoxUnchecked() {
        checkBoxImageView.image = UIImage(named: Constants.checkBoxNotCheckedImageName)
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

        struct NameTextField {
            static let clipsToBounds: Bool = true
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
        }

        struct SurnameTextField {
            static let clipsToBounds: Bool = true
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
        }

        struct BalanceTextField {
            static let clipsToBounds: Bool = true
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
        }

        struct RegisterButton {
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let shadowOffset: CGSize = CGSize(width: 5, height: 5)
            static let shadowColor: UIColor = .gray
            static let shadowOpacity: Float = 1
            static let backgroundColor: UIColor = UIColor(red: 113 / 255,
                                                          green: 101 / 255,
                                                          blue: 227 / 255,
                                                          alpha: 1)
        }

        struct CheckBoxImageView {
            static let recognizerTapsRequired: Int = 1

            static let isUserInteractionEnabled: Bool = true
        }

        static let namePlaceholderText = String(repeating: " ", count: 4) + "Name"
        static let surnamePlaceholderText = String(repeating: " ", count: 4) + "Surname"
        static let balancePlaceholderText = String(repeating: " ", count: 4) + "Start Balance"

        static let checkBoxIsCheckedImageName: String = "checkBoxChecked"
        static let checkBoxNotCheckedImageName: String = "checkBoxNotChecked"

        struct TapRecognizer {
            static let tapsRequired: Int = 1
        }
    }
}
