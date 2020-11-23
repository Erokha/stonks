import UIKit

final class MePresenter {
    weak var view: MeInput?
    var router: MeRouterInput?
    private var interactor: MeInteractorInput
    private var shouldUpdateData: Bool

    var user: MeUserData? {
        didSet {
            let name = user?.name ?? ""
            let surname = user?.surname ?? ""
            let userBalance = user?.balance ?? 0
            let userSpent = user?.totalSpent ?? 0
            view?.setUserData(name: name, lastname: surname, image: user?.avatar)
            view?.setUserCurrentBalance(currentBalance: userBalance)
            view?.setUserSpentInfo(spent: userSpent)
        }
    }

    init(interactor: MeInteractorInput) {
        self.interactor = interactor
        self.shouldUpdateData = false
    }
}

extension MePresenter: MeOutput {
    func didImageLoaded(image: UIImage) {
        if let data = image.pngData() {
            interactor.saveImage(pngData: data)
        } else {
            let alert = UIAlertController(title: Constants.failConvertImgTitle,
                                          message: Constants.failConvertImgMessage,
                                          preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            view?.showAlert(alert: alert)
        }
    }

   func didIndexChanged(index: Int) {
        switch index {
        case 0:
            view?.setPage(with: .mePortfolio)
        case 1:
            view?.setPage(with: .meSettings)
        default:
            break
        }
    }

    func didLoadView() {
        self.shouldUpdateData = true
        interactor.loadUser()
    }
}

extension MePresenter: MeInteractorOutput {
    func didChangeContetnt(user: MeUserData) {
        if shouldUpdateData {
            view?.setUserData(name: user.name, lastname: user.surname, image: nil)
            view?.setUserSpentInfo(spent: user.totalSpent)
            view?.setUserCurrentBalance(currentBalance: user.balance)
        }
    }

    func didReceive(user: MeUserData) {
        self.user = user
    }
}

extension MePresenter {
    struct Constants {
        static let failConvertImgTitle = "Oops"
        static let failConvertImgMessage = "Cannot convert image!"
    }
}
