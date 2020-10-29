import Foundation
import Alamofire

final class ArticleInteractor {
    weak var output: ArticleInteractorOutput?
    var requestUrl: String

    init(with url: String) {
        self.requestUrl = url
    }

    private func handleError() {
        output?.didReciveError()
    }
}

extension ArticleInteractor: ArticleInteractorInput {
    func loadStoks() {
        let request = AF.request(self.requestUrl)
        request.responseDecodable(of: [ArticleModel].self) { [weak self] response in
            switch response.result {
            case .success(let data):
                self?.output?.didRecive(articles: data)
            case .failure:
                self?.handleError()
            }
        }
    }

}
