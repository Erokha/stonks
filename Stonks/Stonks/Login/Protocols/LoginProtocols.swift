import Foundation

protocol LoginViewOutput: class {
    func didTapRegisterButton(name: String?, surname: String?, balance: String?)
    func didTapCheckBox()
    func didLoadView()
    func didStartNameEditing()
    func didFinishNameEditing()
    func didStartSurnameEditing()
    func didFinishSurnameEditing()
    func didStartBalanceEditing()
    func didFinishBalanceEditing()
    func didTapView()
}

protocol LoginViewInput: class {
    func setCheckBoxChecked()
    func setCheckBoxUnchecked()
    func showAlert(with title: String, message: String)
    func setNameTextField(isEditing: Bool)
    func setSurnameTextField(isEditing: Bool)
    func setBalanceTextField(isEditing: Bool)
    func disableKeyboard()
}

protocol LoginRouterInput: class {
    func showMainScreen()
}

protocol LoginInteractorInput: class {
    func toggleTermsState()
    func termsAreAccepted() -> Bool
    func createUser(name: String, surname: String, balance: Decimal)
}

protocol LoginInteractorOutput: class {
    func userSuccesfullyAuthorized()
    func showAlert(with title: String, message: String)
}
