import UIKit

class MePresenter {
    weak var view: MeInput?
    var router: MeRouterInput?
    private var interactor: MeInteractorInput
    private var shouldUpdateData: Bool

    var user: User? {
        didSet {
            let name = String(user?.name ?? "")
            let surname = String(user?.surname ?? "")
            let userBalance = Float(truncating: user?.balance ?? 0)
            let userSpent = Float(truncating: user?.totalSpent ?? 0)
            view?.setUserData(name: name, lastname: surname, image: nil)
            view?.setUserCurrentBalance(currentBalance: Int(userBalance))
            view?.setUserSpentInfo(spent: Int(userSpent))
        }
    }

    init(interactor: MeInteractorInput) {
        self.interactor = interactor
        self.shouldUpdateData = false
    }
}

extension MePresenter: MeOutput {
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
    func didChangeContetnt(user: User) {
        if shouldUpdateData {
            view?.setUserData(name: user.name, lastname: user.surname, image: nil)
            view?.setUserSpentInfo(spent: Int(truncating: user.totalSpent))
            let balance = Float(truncating: user.balance)
            view?.setUserCurrentBalance(currentBalance: Int(balance))
        }
    }

    func didReceive(user: User) {
        self.user = user
    }
}
