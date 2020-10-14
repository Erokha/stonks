import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var myView: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupLeftSideCard()
        setupRightSideCard()
        setCorners()
    }
    
    private func setupLeftSideCard() {
        myView.showUpperTextLeft(text: "Avaliable balance")
        myView.showNumberLeft(num: 2700)
    }
    
    private func setupRightSideCard() {
        myView.showUpperTextRight(text: "Stocks total")
        myView.showNumberRight(num: 1400)
    }
    
    private func setCorners() {
        self.myView.clipsToBounds = true
        self.myView.layer.cornerRadius = 20
    }
}
