import Alamofire

protocol NetworkServiceInput {
    func getAllStocks(completion: @escaping (Result<[StockRaw], Error>) -> Void)
}
