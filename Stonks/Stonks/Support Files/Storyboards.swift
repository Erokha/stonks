enum Storyboard {
    case login
    case stockDetail
    case settings
    case mainStocks
    case mePage
    case meHistoryPage
    case meFilterPage
}

extension Storyboard {
    var name: String {
        switch self {
        case .login:
            return Constants.login
        case .stockDetail:
            return Constants.stockDetail
        case .settings:
            return Constants.settings
        case .mainStocks:
            return Constants.mainStocks
        case .mePage:
            return Constants.mePage
        case .meHistoryPage:
            return Constants.meHistoryPage
        case .meFilterPage:
            return Constants.meFilterPage
        }
    }
}

private struct Constants {
    static let login = "Login"
    static let stockDetail = "StockDetail"
    static let settings = "Settings"
    static let mainStocks = "MainStocks"
    static let mePage = "MePage"
    static let meHistoryPage = "MeHistoryPage"
    static let meFilterPage = "MeFilterPage"
}
