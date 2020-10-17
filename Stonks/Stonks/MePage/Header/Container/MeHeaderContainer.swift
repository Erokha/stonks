import UIKit

class MeHeaderContainer {
    let viewController: MeHeaderViewController
    
    class func assemble(with context: MeHeaderContext) -> MeHeaderContainer {
        let storyboard = UIStoryboard(name: "Me", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "MeHeaderVc") as? MeHeaderViewController else {
            fatalError("MeHeader Container: viewController must be type MeHeaderViewController")
        }
        
        let presenter = MeHeaderPresenter()
    
        vc.presenter = presenter
        return MeHeaderContainer(view: vc)
    }
    
    init(view: MeHeaderViewController) {
        self.viewController = view
    }
}


struct MeHeaderContext {
    
}
