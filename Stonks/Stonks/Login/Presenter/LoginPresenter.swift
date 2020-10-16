import Foundation

class LoginPresenter {
    weak var view: LoginViewInput?
    var router: LoginRouterInput?

    private var model: LoginData

    private var termsAccepted: Bool = false

    init(model: LoginData) {
        self.model = model
    }

    private func toogleTermsState() {
        termsAccepted = !termsAccepted
    }
}

extension LoginPresenter: LoginViewOutput {
    func didTapCheckBox() {
        toogleTermsState()

        view?.setCheckBoxImage(isChecked: termsAccepted)
    }

    func didLoadView() {
        termsAccepted = model.isChecked
        view?.setCheckBoxImage(isChecked: termsAccepted)
    }

    func didStartNameEditing() {
        view?.setNameTextField(isEditing: true)
    }

    func didFinishNameEditing() {
        view?.setNameTextField(isEditing: false)
    }

    func didStartBalanceEditing() {
        view?.setBalanceTextField(isEditing: true)
    }

    func didFinishBalanceEditing() {
        view?.setBalanceTextField(isEditing: false)
    }

    func didTapView() {
        view?.disableKeyboard()
    }

    func didTapRegisterButton(fullName: String?, balance: String?) {
        guard let fullName = fullName,
              !fullName.isEmpty else {
            view?.showAlert(with: "Ошибка", message: "Необходимо ввести имя")
            return
        }

        guard let balanceString = balance,
              !balanceString.isEmpty else {
            view?.showAlert(with: "Ошибка", message: "Необходимо ввести баланс")
            return
        }

        guard let balance = Decimal(string: balanceString) else {
            view?.showAlert(with: "Ошибка", message: "Невозможно преобразовать баланс в число")
            return
        }

        guard termsAccepted else {
            view?.showAlert(with: "Ошибка", message: "Необходимо принять пользовательское соглашение")
            return
        }

        model.fullName = fullName
        model.balance = balance

        // Навигация
        router?.showMainScreen()
    }
}
