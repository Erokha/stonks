import UIKit

protocol MeSettingsInput: class {
    func showAlert(alert: UIAlertController)
}

protocol MeSettingsOutput: class {
    func createDepositAlert()
    func createChangeNameAlert()
}
