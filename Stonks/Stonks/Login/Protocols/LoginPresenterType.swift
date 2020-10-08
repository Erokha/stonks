//
//  LoginViewModelType.swift
//  Stonks
//
//  Created by Vlad on 04.10.2020.
//

import Foundation

protocol LoginPresenterType: class {
    func termsAreAccepted() -> Bool
    
    func setTermsState(state: Bool)
    
    func login(fullName: String, balance: Decimal) -> Bool
}
