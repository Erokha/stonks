//
//  ViewController.swift
//  Stonks
//
//  Created by Vlad on 04.10.2020.
//

import UIKit

class LoginViewController: UIViewController, LoginViewType {

    var presenter: LoginPresenterType!
    
    @IBOutlet weak var welcomeImage: UIImageView!
    
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var balanceEntry: UITextField!
    
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var checkBoxDescription: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    let defaultStyleEntriesColor: UIColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
    let editingStyleEntriesBorderColor: UIColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 1)
    let editingStyleEntriesColor: UIColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 0.2)
    
    let cornerRadius: CGFloat = 10
    let borderWidth: CGFloat = 1
    
    let namePlaceholderText = "Full Name"
    let balancePlaceholderText = "Start Balance"
    
    let checkBoxIsCheckedImageName: String = "checkBoxIsChecked"
    let checkBoxNotCheckedImageName: String = "checkBoxNotChecked"
    
    private func setupNameEntry() {
        nameEntry.attributedPlaceholder = NSAttributedString(string: String(repeating: " ", count: 5) + namePlaceholderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        nameEntry.clipsToBounds = true
        nameEntry.borderStyle = .roundedRect
        nameEntry.layer.cornerRadius = cornerRadius
        nameEntry.layer.borderWidth = borderWidth
        nameEntry.layer.borderColor = defaultStyleEntriesColor.cgColor
        nameEntry.backgroundColor = defaultStyleEntriesColor
        
        nameEntry.addTarget(self, action: #selector(setupNameEditing), for: .editingDidBegin)
        nameEntry.addTarget(self, action: #selector(setupNameDefault), for: .editingDidEnd)
    }
    
    private func setupBalanceEntry() {
        balanceEntry.attributedPlaceholder = NSAttributedString(string: String(repeating: " ", count: 5) + balancePlaceholderText,
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        balanceEntry.clipsToBounds = true
        balanceEntry.borderStyle = .roundedRect
        balanceEntry.layer.cornerRadius = cornerRadius
        balanceEntry.layer.borderWidth = borderWidth
        balanceEntry.layer.borderColor = defaultStyleEntriesColor.cgColor
        balanceEntry.backgroundColor = defaultStyleEntriesColor
        
        balanceEntry.addTarget(self, action: #selector(setupBalanceEditing), for: .editingDidBegin)
        balanceEntry.addTarget(self, action: #selector(setupBalanceDefault), for: .editingDidEnd)
    }
    
    private func setupCheckBox() {
        let boxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(configureCheckbox))
        
        boxTapRecognizer.numberOfTapsRequired = 1
        checkBox.addGestureRecognizer(boxTapRecognizer)
        checkBox.isUserInteractionEnabled = true
    }
    
    private func setupRegisterButton() {
        registerButton.layer.cornerRadius = cornerRadius
        registerButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        registerButton.layer.shadowRadius = cornerRadius
        registerButton.layer.shadowColor = UIColor.gray.cgColor
        registerButton.layer.shadowOpacity = 1
    }
    
    private func setupSubviews() {
        setupNameEntry()
        setupBalanceEntry()
        setupCheckBox()
        setupRegisterButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(disableKeyboard))
        
        viewTapRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(viewTapRecognizer)
    }
    
    @objc private func disableKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func configureCheckbox() {
        guard let presenter = presenter else { return }
        
        if !presenter.termsAreAccepted() {
            checkBox.image = UIImage(named: checkBoxNotCheckedImageName)
        }
        else {
            checkBox.image = UIImage(named: checkBoxIsCheckedImageName)
        }
        
        presenter.setTermsState(state: (presenter.termsAreAccepted() == true ? false : true))
    }
    
    @objc private func setupNameEditing() {
        nameEntry.backgroundColor = editingStyleEntriesColor
        nameEntry.layer.borderColor = editingStyleEntriesBorderColor.cgColor
    }

    @objc private func setupNameDefault() {
        nameEntry.backgroundColor = defaultStyleEntriesColor
        nameEntry.layer.borderColor = defaultStyleEntriesColor.cgColor
    }
    
    @objc private func setupBalanceEditing() {
        balanceEntry.backgroundColor = editingStyleEntriesColor
        balanceEntry.layer.borderColor = editingStyleEntriesBorderColor.cgColor
    }

    @objc private func setupBalanceDefault() {
        balanceEntry.backgroundColor = defaultStyleEntriesColor
        balanceEntry.layer.borderColor = defaultStyleEntriesColor.cgColor
    }
    
    @IBAction func registerAccount(_ sender: UIButton) {
        guard let fullName = nameEntry.text,
              let balanceString = balanceEntry.text else { return }
        
        guard let balanceDecimal = Decimal(string: balanceString) else { return }
              
        guard let presenter = presenter else { return }
        
        if !presenter.login(fullName: fullName, balance: balanceDecimal) {
            // показать алерт
        }
    }
}

