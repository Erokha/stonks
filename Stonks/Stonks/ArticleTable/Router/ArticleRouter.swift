import UIKit

class ArticleRouter {
    weak var viewController: UIViewController?
}

extension ArticleRouter: ArticleRouterInput {
    func showError(with error: Error) {
        let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.viewController?.present(alert, animated: true)
    }
}
