//
//  LoginViewModel.swift
//  Stonks
//
//  Created by Vlad on 04.10.2020.
//

import Foundation

class LoginPresenter: LoginPresenterType {
    
    unowned var view: LoginViewType
    var model: Login
    
    required init(view: LoginViewType, model: Login) {
        self.view = view
        self.model = model
    }
}
