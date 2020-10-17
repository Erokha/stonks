import UIKit

class LoginContainer {
    let viewController: LoginViewController
    private weak var router: LoginRouter?

    class func assemble(with context: LoginContext) -> LoginContainer {
        let storyboard = UIStoryboard(name: Storyboard.login.name, bundle: nil)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: Storyboard.login.name) as? LoginViewController else {
            fatalError("LoginContainer: viewController must be type LoginViewController")
        }

        let model = LoginData(name: nil,
                              surname: nil,
                              balance: nil,
                              isChecked: context.isChecked)

        let presenter = LoginPresenter(model: model)
        let router = LoginRouter()

        viewController.output = presenter
        presenter.view = viewController
        presenter.router = router

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
