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

    @IBOutlet private weak var articleTextView: UITextView!
    @IBOutlet private weak var articleImageView: UIImageView!
    @IBOutlet private weak var articleReadMoreButton: UIButton!
    private var url: URL?

    func load(with model: ArticleModel) {
        self.articleTextView.text = model.text
        let imageUrl = URL(string: model.image)
        self.articleImageView.kf.setImage(with: imageUrl)
        self.url = URL(string: model.url)
        self.setupShadow()
    }

    @IBAction private func didTapReadMoreButton(_ sender: Any) {
        guard let url = self.url else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
        }
    }

}

extension UIView {
    func setupShadow() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
   }
}
