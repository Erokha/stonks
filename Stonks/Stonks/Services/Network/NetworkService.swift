import Alamofire
import Foundation

struct Result<DataType, ErrorType> {
    var data: DataType?
    var error: ErrorType?
}

class NetworkService {
    static let shared = NetworkService()

    private init() {

    }
}

extension NetworkService: NetworkServiceInput {
    func fetchAllStocks(completion: @escaping (Result<[StockRaw], Error>) -> Void) {
        let request = AF.request(Constants.baseURL + Constants.allStocksPath)

        request.responseDecodable(of: [StockRaw].self) { response in
            var result = Result<[StockRaw], Error>()

            switch response.result {
            case .success(let stocks):
                result.data = stocks
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }

    func fetchArticles(type: ArticleType, completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        var url = Constants.baseURL

        if type == .learn {
            url += Constants.learnPath
        } else {
            url += Constants.newsPath
        }

        let request = AF.request(url)

        request.responseDecodable(of: [ArticleModel].self) { response in
            var result = Result<[ArticleModel], Error>()

            switch response.result {
            case .success(let articles):
                result.data = articles
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }

    func fetchStockName(for symbol: String, completion: @escaping (Result<String, Error>) -> Void) {
        let request = AF.request(Constants.baseURL + "stock/\(symbol)")

        request.responseDecodable(of: [StockRaw].self) { response in
            var result = Result<String, Error>()

            switch response.result {
            case .success(let stocks):
                result.data = stocks.first?.stockName
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }

    func fetchStockImageUrl(for symbols: [String], completion: @escaping (Result<[String: String], Error>) -> Void) {
        var url = Constants.baseURL + "stock/"

        guard !symbols.isEmpty else {
            return
        }

        for symbol in symbols {
            url += "\(symbol),"
        }

        url.removeLast()
        let request = AF.request(url)
        request.responseDecodable(of: [StockRaw].self) { response in
            var result = Result<[String: String], Error>()
            var dict = [String: String]()
            switch response.result {
            case .success(let stocks):
                for stock in stocks {
                    dict[stock.stockSymbol] = stock.imageUrl
                }
                result.data = dict
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }
    func fetchStockHistory(for symbol: String, completion: @escaping (Result<[Float], Error>) -> Void) {
        let request = AF.request(Constants.baseURL + "history/\(symbol)")

        request.responseDecodable(of: [HistoryRaw].self) { response in
            var result = Result<[Float], Error>()

            switch response.result {
            case .success(let history):
                result.data = []

                history.forEach { historyPoint in
                    result.data?.append(historyPoint.close)
                }
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }

    func fetchStocksFreshPrice(for symbols: [String], completion: @escaping (Result<[StockRaw], Error>) -> Void) {
        var url = Constants.baseURL + "stock/"

        guard !symbols.isEmpty else {
            return
        }

        for symbol in symbols {
            url += "\(symbol),"
        }

        url.removeLast()

        let request = AF.request(url)

        request.responseDecodable(of: [StockRaw].self) { response in
            var result = Result<[StockRaw], Error>()

            switch response.result {
            case .success(let stocks):
                result.data = stocks
            case .failure(let error):
                result.error = error
            }

            completion(result)
        }
    }
}

extension NetworkService {
    private struct Constants {
        static let baseURL: String = "http://stonks.kkapp.ru:8000/"

        static let allStocksPath: String = "allStocks"
        static let learnPath: String = "learn"
        static let newsPath: String = "news"
    }
}
