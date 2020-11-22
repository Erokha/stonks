import Alamofire
import Foundation

protocol NetworkServiceInput {

    func fetchStockName(for symbol: String, completion: @escaping (Result<String, Error>) -> Void)

    func fetchStockHistory(for symbol: String, completion: @escaping (Result<[Float], Error>) -> Void)

    func fetchStocksFreshPrice(for symbols: [String], completion: @escaping (Result<[StockRaw], Error>) -> Void)

    func fetchAllStocks(completion: @escaping (Result<[StockRaw], Error>) -> Void)

    func fetchArticles(type: ArticleType, completion: @escaping (Result<[ArticleModel], Error>) -> Void)

    func fetchStockImageUrl(for symbols: [String], completion: @escaping (Result<[String: String], Error>) -> Void)
}
