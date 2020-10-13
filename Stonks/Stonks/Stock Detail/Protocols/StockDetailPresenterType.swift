import Foundation

protocol StockDetailPresenterType: class {
    func fetchData() -> [(Date, Double)]
}
