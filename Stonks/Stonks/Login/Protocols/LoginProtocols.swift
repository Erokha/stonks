import Foundation

protocol LoginViewOutput: AnyObject {
    func didTapRegisterButton(name: String?, surname: String?, balance: String?)

    func didTapCheckBox()

    func didLoadView()

    func didStartNameEditing()

    func didFinishNameEditing()

    func didStartSurnameEditing()

    func didFinishSurnameEditing()

    func didStartBalanceEditing()

    func didFinishBalanceEditing()

    func didTapGoogleSignInButton()

    func didTapView()
}

protocol LoginViewInput: AnyObject {
    func setCheckBoxChecked()

    func setCheckBoxUnchecked()

    func showAlert(with title: String, message: String)

    func setNameTextField(isEditing: Bool)

    func setSurnameTextField(isEditing: Bool)

    func setBalanceTextField(isEditing: Bool)

    func disableKeyboard()
}

protocol LoginRouterInput: AnyObject {
    func showMainScreen()
}

protocol LoginInteractorInput: AnyObject {
    func toggleTermsState()

    func termsAreAccepted() -> Bool

    func createUser(name: String, surname: String, balance: Decimal)

    func signInWithGoogle()
}

protocol LoginInteractorOutput: AnyObject {
    func userSuccesfullyAuthorized()

    func showAlert(with title: String, message: String)
}
