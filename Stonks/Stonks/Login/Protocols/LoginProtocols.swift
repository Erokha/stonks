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
    func setCheckBoxImage(isChecked: Bool)
    func showAlert(with title: String, message: String)
    func setNameTextField(isEditing: Bool)
    func setSurnameTextField(isEditing: Bool)
    func setBalanceTextField(isEditing: Bool)
    func disableKeyboard()
}

protocol LoginRouterInput: class {
    func showMainScreen()
}
