import UIKit

class MeSettingsPresenter {
    weak var view: MeSettingsInput?

    required init() {
    }

    private func saveDeposit(money: Int) {
        print("Money:", money)
        // Add money to Core data
    }

    private func saveName(name: String) {
        print("Name:", name)
        // Save new name to Core Data
    }

    private func saveSurname(surname: String) {
        print("Surname:", surname)
        // Save new surname to Core Data
    }
}

extension MeSettingsPresenter: MeSettingsOutput {
    func createChangeNameAlert() {
        let alert = UIAlertController(title: MeSettingsPresenter.Constants.changeNameTitle, message: MeSettingsPresenter.Constants.changeNameMessage, preferredStyle: UIAlertController.Style.alert )
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            if let nameTextField = alert.textFields?[0] {
                if let name = nameTextField.text {
                    if !name.isEmpty {
                        self.saveName(name: name)
                    }
                }
            }
            if let surnameTextField = alert.textFields?[1] {
                if let surname = surnameTextField.text {
                    if !surname.isEmpty {
                        self.saveSurname(surname: surname)
                    }
                }
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
            textField.keyboardType = .asciiCapable
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Surname"
            textField.keyboardType = .asciiCapable
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_) in }
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

    func createDepositAlert() {
        let alert = UIAlertController(title: MeSettingsPresenter.Constants.addDepositTitle, message: MeSettingsPresenter.Constants.addDepositMessage, preferredStyle: UIAlertController.Style.alert )
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            if let textField = alert.textFields?[0] {
                if let text = textField.text {
                    if let money = Int(text) {
                        self.saveDeposit(money: money)
                    }
                }
            }
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Amount of money"
            textField.keyboardType = .numberPad
        }
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (_) in }
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }
}

extension MeSettingsPresenter {
    struct Constants {
        static let addDepositTitle: String = "Add deposit."
        static let addDepositMessage: String = "Enter amount ofmoney you want to add:"
        static let changeNameTitle: String = "Change name."
        static let changeNameMessage: String = "Enter your new name:"
    }
}
