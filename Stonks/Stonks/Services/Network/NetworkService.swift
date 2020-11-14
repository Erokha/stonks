import Alamofire
import Foundation

class Result<DataType, ErrorType> {
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
            let result = Result<[StockRaw], Error>()

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
            let result = Result<[ArticleModel], Error>()

            switch response.result {
            case .success(let articles):
                result.data = articles
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
