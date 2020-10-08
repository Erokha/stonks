import UIKit

class ContainerViewController: UIViewController {
    @IBOutlet weak var myView: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myView.showUpperTextLeft(text: "Avaliable balance")
        myView.showUpperTextRight(text: "Stocks total")
        myView.showNumberLeft(num: 2700)
        myView.showNumberRight(num: 1400)
        setCorners()
    }
    
    private func setCorners() {
        self.myView.clipsToBounds = true
        self.myView.layer.cornerRadius = 20
    }
}
