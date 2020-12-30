import UIKit
import MessageUI

final class MeSettingsPresenter {
    weak var view: MeSettingsInput?
    var interactor: MeSettingsInteractorInput

    required init(interactor: MeSettingsInteractorInput) {
        self.interactor = interactor
    }

    private func saveDeposit(money: Int) {
        let user = interactor.loadUser()
        let userMoneyFloat = Float(truncating: user.balance)
        let userMoney = Int(userMoneyFloat)
        let totalSpentFloat = Float(truncating: user.totalSpent)
        var totalSpent = Int(totalSpentFloat)
        var totalBalance = money + userMoney
        if totalBalance < 0 {
            totalBalance = 0
        }
        if money > 0 {
            totalSpent += money
        }
        user.balance = NSDecimalNumber(value: totalBalance)
        user.totalSpent = NSDecimalNumber(value: totalSpent)
        interactor.saveChanges(for: user)
    }

    private func saveName(name: String, surname: String) {
        let user = interactor.loadUser()
        if !name.isEmpty {
            user.name = name
        }
        if !surname.isEmpty {
            user.surname = surname
        }
        interactor.saveChanges(for: user)
    }

    private func resetData() {
        let user = interactor.loadUser()
        user.balance = 0
        user.totalSpent = 0
        interactor.saveChanges(for: user)
        interactor.resetData()

    }
    private func configureMailComposer() -> MFMailComposeViewController {
        let mailComposeVc = MFMailComposeViewController()

        mailComposeVc.setToRecipients([MeSettingsPresenter.Constants.mailToSend])
        mailComposeVc.setSubject(MeSettingsPresenter.Constants.mailSubject)
        mailComposeVc.setMessageBody(MeSettingsPresenter.Constants.mailBody, isHTML: false)
        return mailComposeVc
    }
}

extension MeSettingsPresenter: MeSettingsOutput {
    func aboutUs() {
        let alert = UIAlertController(title: MeSettingsPresenter.Constants.aboutUsTitle, message: MeSettingsPresenter.Constants.aboutUsMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        view?.showAlert(alert: alert)
    }

    func isUserSure() {
        let alert = UIAlertController(title: MeSettingsPresenter.Constants.resetDataTitle, message: MeSettingsPresenter.Constants.resetDataMessage, preferredStyle: UIAlertController.Style.alert )
        let reset = UIAlertAction(title: "Reset", style: .default) { (_) in
            self.resetData()
        }
        alert.addAction(reset)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            view?.showMailComposer(mailComposer: configureMailComposer())
        } else {
            let alert = UIAlertController(title: "Error!", message: "Sorry but email service is not avaliable at the moment.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            view?.showAlert(alert: alert)
        }
    }

    func createChangeNameAlert() {
        let alert = UIAlertController(title: MeSettingsPresenter.Constants.changeNameTitle, message: MeSettingsPresenter.Constants.changeNameMessage, preferredStyle: UIAlertController.Style.alert )
        let save = UIAlertAction(title: "Save", style: .default) { (_) in
            var correctName = ""
            var correctSurname = ""
            if let nameTextField = alert.textFields?[0] {
                if let name = nameTextField.text {
                    if !name.isEmpty {
                        correctName = name
                    }
                }
            }
            if let surnameTextField = alert.textFields?[1] {
                if let surname = surnameTextField.text {
                    if !surname.isEmpty {
                        correctSurname = surname
                    }
                }
            }
            self.saveName(name: correctName, surname: correctSurname)
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
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
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
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        view?.showAlert(alert: alert)
    }
}

extension MeSettingsPresenter: MeSettingsInteractorOutput {
    func didAllEntitiesDeleted() {
        guard let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        appDelegate.reloadUserData()
    }
}

extension MeSettingsPresenter {
    struct Constants {
        static let addDepositTitle: String = "Add deposit."
        static let addDepositMessage: String = "Enter amount ofmoney you want to add:"
        static let changeNameTitle: String = "Change name."
        static let changeNameMessage: String = "Enter your new name:"
        static let mailToSend: String = "stonks.official@mail.ru"
        static let mailBody: String = "Please, tell us what happened!"
        static let mailSubject: String = "Report error."
        static let resetDataTitle: String = "Warining!"
        static let resetDataMessage: String = "You are going to reset all data, all data will be lost. Are you sure? "
        static let aboutUsTitle: String = "About us."
        static let aboutUsMessage: String = "Stonks, 2020"
    }
}
