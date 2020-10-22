import Foundation

class MeSettingsContainer {
    let viewController: MeSettingsViewController

    class func asseble(with context: MeSettingsContext) -> MeSettingsContainer {
        let vc = MeSettingsViewController()
        let presenter = MeSettingsPresenter()

        vc.presenter = presenter
        presenter.view = vc
        return MeSettingsContainer(view: vc)
    }

    private init(view: MeSettingsViewController) {
        self.viewController = view
    }
}

struct MeSettingsContext {

}
