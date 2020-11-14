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
    func getAllStocks(completion: @escaping (Result<[StockRaw], Error>) -> Void) {
        let request = AF.request(Constants.baseURL + Constants.allStocksPath)

        request.responseDecodable(of: [StockRaw].self) { response in
            let result = Result<[StockRaw], Error>()

            switch response.result {
            case .success(let stocks):
                result.data = stocks
                completion(result)
            case .failure(let error):
                result.error = error
                completion(result)
            }
        }
    }
}

extension NetworkService {
    private struct Constants {
        static let baseURL: String = "http://stonks.kkapp.ru:8000/"

        static let allStocksPath: String = "allStocks"
    }
}
