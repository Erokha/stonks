import UIKit

class ArticleViewPresenter {
    var model: [ArticleModel]? {
        didSet {
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    weak var view: ArticleViewInput?
    private let interactor: ArticleInteractorInput
    var tableViewTitle: String?
    var router: ArticleRouterInput?

    init(interactor: ArticleInteractorInput) {
        self.interactor = interactor
    }
}

extension ArticleViewPresenter: ArticleViewOutput {
    func refreshData() {
        interactor.loadStoks()
    }

    func didLoadView() {
        view?.startActivity()
        interactor.loadStoks()
        self.view?.setTableViewTitle(self.tableViewTitle ?? "")
    }

    func article(at indexPath: IndexPath) -> ArticleModel? {
        return self.model?[indexPath.section] ?? nil
    }

    func numberOfItems() -> Int {
        return self.model?.count ?? 0
    }

}

extension ArticleViewPresenter: ArticleInteractorOutput {

    func didRecive(articles: [ArticleModel]) {
        self.model = articles
        view?.endActivity()
    }

    func didReciveError(with error: Error) {
        router?.showError(with: error)
        view?.endActivity()
    }

}
