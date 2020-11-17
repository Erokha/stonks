//
//  ArticleTableViewCell.swift
//  swifttest
//
//  Created by kymblc on 28.10.2020.
//

import UIKit
import Kingfisher
import SafariServices

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet private weak var articleTextView: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleReadMoreButton: UIButton!
    weak var output: ArticleViewOutput?

    private var url: URL?

    func load(with model: ArticleModel, output: ArticleViewOutput?) {
        self.articleTextView.text = model.text
        let imageUrl = URL(string: model.image)
        self.articleImageView.kf.setImage(with: imageUrl)
        self.url = URL(string: model.url)
        self.output = output
        self.setupShadow()
        self.selectionStyle = .none
    }

    @IBAction private func didTapReadMoreButton(_ sender: Any) {
        output?.didTapReadMore(url: url)
    }

}

extension UIView {
    func setupShadow() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
   }
}
