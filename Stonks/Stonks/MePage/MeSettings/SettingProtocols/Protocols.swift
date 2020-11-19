import UIKit
import MessageUI

protocol MeSettingsInput: class {
    func showAlert(alert: UIAlertController)
    func showMailComposer(mailComposer: MFMailComposeViewController)
}

protocol MeSettingsOutput: class {
    func createDepositAlert()
    func createChangeNameAlert()
    func sendEmail()
    func isUserSure()
    func aboutUs()
}

protocol MeSettingsInteractorInput: class {
    func saveChanges(for user: User)
    func loadUser() -> User
    func resetData()
}
protocol MeSettingsInteractorOutput: class {
    func didAllEntitiesDeleted()
}
