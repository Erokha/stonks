import UIKit
import Kingfisher

struct ArticleModel: Decodable {
    public let image: String
    public let text: String
    public let url: String

    private enum CodingKeys: String, CodingKey {
        case image
        case text
        case url
    }
}
