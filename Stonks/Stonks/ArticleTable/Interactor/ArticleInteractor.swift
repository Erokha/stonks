import Foundation
import Alamofire

final class ArticleInteractor {
    weak var output: ArticleInteractorOutput?

    private let type: ArticleType

    init(type: ArticleType) {
        self.type = type
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
        NetworkService.shared.fetchArticles(type: type) { [weak self] result in
            if let error = result.error {
                self?.handleError(with: error.asAFError(orFailWith: "Undefined Error"))
                return
            }

            guard let articles = result.data else {
                return
            }

            self?.handleArticle(with: articles)
        }
        /*
        let request = AF.request(self.requestUrl)
        request.responseDecodable(of: [ArticleModel].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.output?.didRecive(articles: data)
            case .failure(let error):
                self?.handleError(with: error)
            }
        }
        */
    }

}
