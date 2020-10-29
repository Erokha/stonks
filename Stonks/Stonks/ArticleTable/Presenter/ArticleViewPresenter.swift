import UIKit

class ArticleViewPresenter {
    var model: [ArticleModel]? {
        didSet {
            print("ive changed")
            DispatchQueue.main.async {
                self.view?.reloadTable()
            }
        }
    }
    weak var view: ArticleViewInput?
    private let interactor: ArticleInteractorInput
    var tableViewTitle: String?

    init(interactor: ArticleInteractorInput) {
        self.interactor = interactor
    }
}

extension ArticleViewPresenter: ArticleViewOutput {
    func refreshData() {
        interactor.loadStoks()
    }

    func didLoadView() {
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
    }

    func didReciveError() {
        self.model = [ArticleModel(image: "http://assimilationsystems.com/wp-content/uploads/2015/04/No-News-Is-Good-News-451x400.png", text: "We have no news. Something went wrong!", url: "google.com")]
    }

}
