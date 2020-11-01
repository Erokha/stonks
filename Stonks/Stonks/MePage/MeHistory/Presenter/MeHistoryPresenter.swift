import Foundation

final class MeHistoryPresenter {
    weak var view: MeHistoryInput?
    private var interactor: MeHistoryInteractorInput
    var router: MeHistoryRouterInput?

    init(interactor: MeHistoryInteractorInput) {
        self.interactor = interactor
    }

}

extension MeHistoryPresenter: MeHistoryOutput {

}

extension MeHistoryPresenter: MeHistoryInteractorOutput {

}
