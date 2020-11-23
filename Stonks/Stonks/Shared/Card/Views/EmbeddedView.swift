import UIKit

class EmbeddedView: UIView, NibLoadableView {
    var view: UIView!

    var metatype: EmbeddedView.Type {
        return type(of: self)
    }

    required init() {
        super.init(frame: .zero)

        setupNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupNib()
    }

    func setupNib() {
        view = loadViewFromNib()
        view.frame = bounds

        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: metatype)
        let nib = UINib(nibName: metatype.nibName, bundle: bundle)

        guard let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return UIView()
        }

        return nibView
    }

    deinit {
        #if DEBUG
        print("*** \(type(of: self).className()) deinited ***")
        #endif
    }
}
