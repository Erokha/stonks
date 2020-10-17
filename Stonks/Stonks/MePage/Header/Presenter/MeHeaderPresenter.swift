import UIKit

class MeHeaderPresenter: MeHeaderOutput {
    weak var view: MeHeaderInput?
    var userName: String?
    var userLastName: String?
    var userImage: String?
    
    required init() {
    }
    
    func didLoadView() {
        // TODO: Load user data from core data
        self.view?.setUserData(name: "Sasha", lastname: "Zakharov", image: UIImage(named: "ZUEV")!)
        self.view?.setUserCurrentBalance(currentBalance: 1000)
        self.view?.setUserSpentInfo(spent: 2000)
    }
    


}
