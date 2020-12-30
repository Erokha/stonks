import Foundation
import UIKit

class ArticleContainer {
    let viewController: ArticleViewController

    class func assemble(with context: ArticleContext) -> ArticleContainer {
        // let storyboard = UIStoryboard(name: Storyboard.article.name, bundle: nil)

//        guard let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.article.name) as? ArticleViewController else {
//            fatalError("ArticleContainer: viewController must be type ArticleViewController")
//        }
        let viewController = ArticleViewController()

        let interactor = ArticleInteractor(type: context.type)
        let presenter = ArticleViewPresenter(interactor: interactor)

        interactor.output = presenter
        let router = ArticleRouter()

        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.tableViewTitle = context.tableViewTitle

        router.viewController = viewController

        return ArticleContainer(view: viewController)
    }

    private init(view: ArticleViewController) {
        self.viewController = view
    }
}

struct ArticleContext {
    let tableViewTitle: String
    let type: ArticleType
}

enum ArticleType {
    case learn
    case news
}
