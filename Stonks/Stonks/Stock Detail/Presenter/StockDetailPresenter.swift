import Foundation

class StockDetailPresenter: StockDetailPresenterType {

    weak var view: StockDetailViewInput?
    var router: StockDetailRouterInput?

    private var model: StockDetailData

    init(model: StockDetailData) {
        self.model = model
    }

    func fetchData() -> [(Date, Double)] {
        // запрос данных
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short

        var dataset: [(Date, Double)] = []
        var time = Date()

        for _ in 0..<20 {
            let value = Double.random(in: 0.0 ... 50.0)
            dataset.append((time, value))
            time.addTimeInterval(60)
        }

        return dataset
    }
}

extension StockDetailPresenter: StockDetailViewOutput {

}
