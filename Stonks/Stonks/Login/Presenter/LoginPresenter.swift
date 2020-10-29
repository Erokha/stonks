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

    func didStartSurnameEditing() {
        view?.setSurnameTextField(isEditing: true)
    }

    func didFinishSurnameEditing() {
        view?.setSurnameTextField(isEditing: false)
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

    func didTapRegisterButton(name: String?, surname: String?, balance: String?) {
        guard let name = name,
              !name.isEmpty else {
            view?.showAlert(with: "Oops!", message: "Please, input your name")
            return
        }

        guard let surname = surname,
              !surname.isEmpty else {
            view?.showAlert(with: "Oops!", message: "Please, input your surname")
            return
        }

        guard let balanceString = balance,
              !balanceString.isEmpty else {
            view?.showAlert(with: "Oops!", message: "Please, input your balance")
            return
        }

        guard let balance = Decimal(string: balanceString) else {
            view?.showAlert(with: "Oops!", message: "Can`t convert balance")
            return
        }

        guard termsAccepted else {
            view?.showAlert(with: "Oops!", message: "Terms need to be accepted")
            return
        }

        model.name = name
        model.surname = surname
        model.balance = balance

        DataService.shared.authorize()
        DataService.shared.createUser(name: name, surname: surname, balance: balance)

        router?.showMainScreen()
    }
}
