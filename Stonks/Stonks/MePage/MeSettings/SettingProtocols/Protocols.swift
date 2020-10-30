import UIKit
import MessageUI

protocol MeSettingsInput: class {
    func showAlert(alert: UIAlertController)
    func showMailComposer(mailComposer: MFMailComposeViewController)
    func didSettingsChanged()
}

protocol MeSettingsOutput: class {
    func createDepositAlert()
    func createChangeNameAlert()
    func sendEmail()
    func isUserSure()
    func aboutUs()
}
