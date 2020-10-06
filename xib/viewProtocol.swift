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

/// View загружаемое из .xib файлов.
protocol NibLoadableView: class, ClassName { }

extension NibLoadableView where Self: UIView {

    /// Имя файла view. Совпадает с названием класса.
    static var nibName: String {
        return className()
    }
}

extension UICollectionViewCell: NibLoadableView {}
extension UITableViewCell: NibLoadableView {}
extension UITableViewHeaderFooterView: NibLoadableView {}
