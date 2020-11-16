import Foundation

final class MeSettingsContainer {
    let viewController: MeSettingsViewController

    class func asseble(with context: MeSettingsContext) -> MeSettingsContainer {
        let vc = MeSettingsViewController()
        let interactor = MeSettingsInteractor()
        let presenter = MeSettingsPresenter(interactor: interactor)
        vc.presenter = presenter
        presenter.view = vc
        interactor.output = presenter
        return MeSettingsContainer(view: vc)
    }

    private init(view: MeSettingsViewController) {
        self.viewController = view
    }
}

struct MeSettingsContext {

}
