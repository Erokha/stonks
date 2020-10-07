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
    @IBOutlet weak var checkBoxDescription: UITextView!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameEntry.clipsToBounds = true
        nameEntry.borderStyle = .roundedRect
        nameEntry.layer.borderColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1).cgColor
        balanceEntry.clipsToBounds = true
        balanceEntry.borderStyle = .roundedRect
        balanceEntry.layer.borderColor = UIColor(red: 250, green: 250, blue: 250, alpha: 1).cgColor
        
        nameEntry.addTarget(self, action: #selector(setupNameEditing), for: .editingDidBegin)
        
        nameEntry.addTarget(self, action: #selector(setupNameDefault), for: .editingDidEnd)
        
        balanceEntry.addTarget(self, action: #selector(setupBalanceEditing), for: .editingDidBegin)
        
        balanceEntry.addTarget(self, action: #selector(setupBalanceDefault), for: .editingDidEnd)
        
        let boxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(configureCheckbox))
        
        boxTapRecognizer.numberOfTapsRequired = 1
        checkBox.addGestureRecognizer(boxTapRecognizer)
        checkBox.isUserInteractionEnabled = true
    }
    
    @objc private func configureCheckbox() {
        if isChecked {
            checkBox.image = UIImage(named: "checkBoxNotChecked")
        }
        else {
            checkBox.image = UIImage(named: "checkBoxIsChecked")
        }
        
        isChecked = (isChecked == true ? false : true)
    }
    
    @objc private func setupNameEditing() {
        nameEntry.backgroundColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 0.2)
        nameEntry.layer.borderColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 1).cgColor
    }

    @objc private func setupNameDefault() {
        nameEntry.backgroundColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
        nameEntry.layer.borderColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1).cgColor
    }
    
    @objc private func setupBalanceEditing() {
        balanceEntry.backgroundColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 0.2)
        balanceEntry.layer.borderColor = UIColor(red: 113 / 255, green: 101 / 255, blue: 227 / 255, alpha: 1).cgColor
    }

    @objc private func setupBalanceDefault() {
        balanceEntry.backgroundColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
        balanceEntry.layer.borderColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1).cgColor
    }
}

