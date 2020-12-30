import UIKit

final class LoginContainer {
    let viewController: LoginViewController
    private weak var router: LoginRouter?

    class func assemble(with context: LoginContext) -> LoginContainer {
        let viewController = LoginViewController()

        let presenter = LoginPresenter()
        let interactor = LoginInteractor(termsAccepted: context.isChecked)
        let router = LoginRouter()

        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.output = presenter

        router.viewController = viewController

        return LoginContainer(view: viewController, router: router)
    }

    private init(view: LoginViewController, router: LoginRouter) {
        self.viewController = view
        self.router = router
    }
}

struct LoginContext {
    let isChecked: Bool
}
