import UIKit

protocol MeHeaderInput: class {
    func setUserData(name: String, lastname: String, image: UIImage)
    func setUserSpentInfo(spent: Int)
    func setUserCurrentBalance(currentBalance: Int)
}

protocol MeHeaderOutput: class {
    func didLoadView()
}
