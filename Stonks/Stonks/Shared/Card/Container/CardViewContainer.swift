import Foundation

final class CardViewContainer {
    let view: NewCardView

    class func assemble(with context: CardViewContext) -> CardViewContainer {
        let vc = NewCardView()

        let presenter = CardViewPresenter(view: vc)

        vc.presenter = presenter
        return CardViewContainer(view: vc)
    }

    private init(view: NewCardView) {
        self.view = view
    }
}

struct CardViewContext {

}
