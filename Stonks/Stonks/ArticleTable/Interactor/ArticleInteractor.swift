import Foundation
import Alamofire

final class ArticleInteractor {
    weak var output: ArticleInteractorOutput?
    var requestUrl: String

    init(with url: String) {
        self.requestUrl = url
    }

    private func handleError(with error: AFError) {
        switch error {
        case .sessionTaskFailed:
            output?.didReciveError(with: AppError.networkError)
        default:
            output?.didReciveError(with: AppError.undefinedError)
        }
    }

    private func handleArticle(with articles: [ArticleModel]) {
        output?.didRecive(articles: articles)
    }
}

extension ArticleInteractor: ArticleInteractorInput {
    func loadStoks() {
        let request = AF.request(self.requestUrl)
        request.responseDecodable(of: [ArticleModel].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.output?.didRecive(articles: data)
            case .failure(let error):
                self?.handleError(with: error)
            }
        }
    }

}
