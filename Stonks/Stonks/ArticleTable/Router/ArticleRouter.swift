import UIKit
import SafariServices

class ArticleRouter {
    weak var viewController: UIViewController?
}

extension ArticleRouter: ArticleRouterInput {
    func showError(with error: Error) {
        let alert = UIAlertController(title: "Error happend", message: error.localizedDescription, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        self.viewController?.present(alert, animated: true)
    }

    func openUrl(_ url: URL?) {
        guard let trueUrl = url else {
            return
        }
        if UIApplication.shared.canOpenURL(trueUrl) {
            let safariViewController = SFSafariViewController(url: trueUrl)
            safariViewController.modalPresentationStyle = .pageSheet
            self.viewController?.present(safariViewController, animated: true, completion: nil)
        }
    }
}
