enum Storyboard {
    case settings
    case mainStocks
    case mePage
    case meHistoryPage
    case meFilterPage
    case article
}

extension Storyboard {
    var name: String {
        switch self {
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
        case .article:
            return Constants.article
        }
    }
}

private struct Constants {
    static let settings = "Settings"
    static let mainStocks = "MainStocks"
    static let mePage = "MePage"
    static let meHistoryPage = "MeHistoryPage"
    static let meFilterPage = "MeFilterPage"
    static let article = "Article"
}
