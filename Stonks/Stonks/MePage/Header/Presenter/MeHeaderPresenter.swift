import UIKit

class MeHeaderPresenter: MeHeaderOutput {
    weak var view: MeHeaderInput?
    var userName: String?
    var userLastName: String?
    var userImage: String?

    required init() {
    }

    func didLoadView() {
        // Here we will load data from UserDefaults
    }

}
