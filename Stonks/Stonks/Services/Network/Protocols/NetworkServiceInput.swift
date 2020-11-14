import Alamofire

protocol NetworkServiceInput {
    func fetchAllStocks(completion: @escaping (Result<[StockRaw], Error>) -> Void)
    func fetchArticles(type: ArticleType, completion: @escaping (Result<[ArticleModel], Error>) -> Void)
}
