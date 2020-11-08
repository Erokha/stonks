import UIKit

protocol ClassName {
    static func className() -> String
}

extension ClassName {

    static func className() -> String {
        return String(describing: self)
    }
}

extension UIViewController: ClassName {}

protocol NibLoadableView: class, ClassName { }

extension NibLoadableView where Self: UIView {

    /// name view. Should match class name
    static var nibName: String {
        return className()
    }
}

extension UICollectionViewCell: NibLoadableView {}
extension UITableViewCell: NibLoadableView {}
extension UITableViewHeaderFooterView: NibLoadableView {}
