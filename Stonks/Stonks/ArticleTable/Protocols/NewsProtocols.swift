import UIKit

protocol ArticleViewInput: class {
    func reloadTable()
    func setTableViewTitle(_ text: String)
    func startActivity()
    func endActivity()
}

protocol ArticleViewOutput: class {
    func didLoadView()
    func numberOfItems() -> Int
    func article(at indexPath: IndexPath) -> ArticleModel?
    func refreshData()
    func didTapReadMore(url: URL?)
}

protocol ArticleInteractorInput: class {
    func loadStoks()
}

protocol ArticleInteractorOutput: class {
    func didRecive(articles: [ArticleModel])
    func didReciveError(with error: Error)
}

protocol ArticleRouterInput: class {
    func showError(with error: Error)
    func openUrl(_ url: URL?)
}
