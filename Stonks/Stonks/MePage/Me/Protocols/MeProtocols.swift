import UIKit

protocol MeInput: class {
    func setUserData(name: String, lastname: String, image: UIImage?)
    func setUserSpentInfo(spent: Int)
    func setUserCurrentBalance(currentBalance: Int)
    func setPage(with page: MePage)
    func showAlert(alert: UIAlertController)
}

protocol MeOutput: class {
    func didLoadView()
    func didIndexChanged(index: Int)
    func didImageLoaded(image: UIImage)
}

protocol MeRouterInput: class {
}

protocol MeInteractorInput: class {
    func loadUser()
    func saveImage(pngData: Data)
}

protocol MeInteractorOutput: class {
    func didReceive(user: MeUserData)
    func didChangeContetnt(user: MeUserData)
}
