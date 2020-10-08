//
//  ViewController.swift
//  Stonks
//
//  Created by Vlad on 04.10.2020.
//

import UIKit

class LoginViewController: UIViewController, LoginViewType {

    var presenter: LoginPresenterType?
    
    @IBOutlet weak var welcomeImage: UIImageView!
    
    @IBOutlet weak var nameEntry: UITextField!
    @IBOutlet weak var balanceEntry: UITextField!
    
    @IBOutlet weak var checkBox: UIImageView!
    @IBOutlet weak var checkBoxDescription: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var isChecked: Bool = false
    
    let defaultStyleEntriesColor: UIColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
    let editingStyleEntriesBorderColor: UIColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 1)
    let editingStyleEntriesColor: UIColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 0.2)
    
    let checkBoxIsCheckedImageName: String = "checkBoxIsChecked"
    let checkBoxNotCheckedImageName: String = "checkBoxNotChecked"
    
    private func setupNameEntry() {
        nameEntry.clipsToBounds = true
        nameEntry.borderStyle = .roundedRect
        nameEntry.layer.borderColor = defaultStyleEntriesColor.cgColor
        nameEntry.backgroundColor = defaultStyleEntriesColor
        
        nameEntry.addTarget(self, action: #selector(setupNameEditing), for: .editingDidBegin)
        nameEntry.addTarget(self, action: #selector(setupNameDefault), for: .editingDidEnd)
    }
    
    private func setupBalanceEntry() {
        balanceEntry.clipsToBounds = true
        balanceEntry.borderStyle = .roundedRect
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
    
    private func setupSubviews() {
        setupNameEntry()
        setupBalanceEntry()
        setupCheckBox()
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
        if !isChecked {
            checkBox.image = UIImage(named: checkBoxNotCheckedImageName)
        }
        else {
            checkBox.image = UIImage(named: checkBoxIsCheckedImageName)
        }
        
        isChecked = (isChecked == true ? false : true)
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
}

