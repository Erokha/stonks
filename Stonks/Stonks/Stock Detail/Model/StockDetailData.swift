struct StockDetailPresenterData {
    var name: String
    var quotes: [(Double, Double)]?

    init(name: String) {
        self.name = name
    }
}

struct StockDetailInteractorData {
    var name: String
    var stock: Stock?

    init(name: String) {
        self.name = name
    }
}
