//
//  Storyboards.swift
//  Stonks
//
//  Created by k.kulakov on 11.10.2020.
//

import Foundation

enum Storyboard {
    case login
    case settings
    case myStocks
}

extension Storyboard {
    var name: String {
        switch self {
        case .login:
            return Constants.login
        case .settings:
            return Constants.settings
        case .myStocks:
            return Constants.myStocks
        }
    }
}

private struct Constants {
    static let login = "Login"
    static let settings = "Settings"
    static let myStocks = "MyStocks"
}
