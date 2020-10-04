//
//  ViewController.swift
//  Stonks
//
//  Created by Vlad on 04.10.2020.
//

import UIKit

class LoginViewController: UIViewController {

    var viewModel: LoginViewModelType?
    
    private lazy var welcomeImage: UIImageView = {
        let image = UIImageView()
        let assetName = "welcome"
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: assetName)
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    private func addSubviews() {
        view.addSubview(welcomeImage)
    }
    
    private func setupWelcomeImageConstraints() {
        let topConstant: CGFloat = 150
        
        welcomeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant).isActive = true
        welcomeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupConstraints() {
        setupWelcomeImageConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }


}

