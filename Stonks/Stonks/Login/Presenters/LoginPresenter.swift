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
    
    private var termsAccepted: Bool = false
    
    required init(view: LoginViewType, model: Login) {
        self.view = view
        self.model = model
    }
    
    func termsAreAccepted() -> Bool {
        return termsAccepted
    }
    
    func setTermsState(state: Bool) {
        termsAccepted = state
    }
    
    func login(fullName: String, balance: Decimal) -> Bool {
        // тут скорее всего запрос в сеть
        // и если все нормально
        
        guard termsAccepted else {
            return false
        }
        
        model.fullName = fullName
        model.balance = balance
        
        // дальше навигация
        
        return true
    }
}
