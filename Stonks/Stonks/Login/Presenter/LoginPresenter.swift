import Foundation

final class LoginPresenter {

    weak var view: LoginViewInput?

    var router: LoginRouterInput?

    var interactor: LoginInteractorInput?
}

extension LoginPresenter: LoginViewOutput {
    func didTapCheckBox() {
        guard let interactor = interactor else {
            return
        }

        interactor.toggleTermsState()
        interactor.termsAreAccepted() ? view?.setCheckBoxChecked() : view?.setCheckBoxUnchecked()
    }

    func didLoadView() {
        guard let interactor = interactor else {
            return
        }

        view?.setGoogleSignInPresentingVC()
        interactor.termsAreAccepted() ? view?.setCheckBoxChecked() : view?.setCheckBoxUnchecked()
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

        interactor?.createUser(name: name, surname: surname, balance: balance)
    }

    func didTapCheckBoxDescriptionLabel() {
        router?.showTermsAndConditions()
    }

    func didTapGoogleSignInButton() {
        interactor?.signInWithGoogle()
    }
}

extension LoginPresenter: LoginInteractorOutput {
    func userSuccesfullyAuthorized() {
        if AuthorizationService.shared.isNewUser() {
            AuthorizationService.shared.setUserIsNotNew()
            router?.showOnboarding()
        } else {
            router?.showMainScreen()
        }
    }

    func showAlert(with title: String, message: String) {
        view?.showAlert(with: title, message: message)
    }
}
