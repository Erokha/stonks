enum Storyboard {
    case login
    case stockDetail
}

extension Storyboard {
    var name: String {
        switch self {
        case .login:
            return Constants.login
        case .stockDetail:
            return Constants.stockDetail
        }
    }
}

private struct Constants {
    static let login = "Login"
    static let stockDetail = "StockDetail"
}
