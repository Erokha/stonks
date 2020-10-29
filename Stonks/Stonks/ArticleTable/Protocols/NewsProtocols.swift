import UIKit

protocol ArticleViewInput: class {
    func reloadTable()
    func setTableViewTitle(_ text: String)
}

protocol ArticleViewOutput: class {
    func didLoadView()
    func numberOfItems() -> Int
    func article(at indexPath: IndexPath) -> ArticleModel?
    func refreshData()
}

protocol ArticleInteractorInput: class {
    func loadStoks()
}

protocol ArticleInteractorOutput: class {
    func didRecive(articles: [ArticleModel])
    func didReciveError()
}
