//
//  ArticleTableViewCell.swift
//  swifttest
//
//  Created by kymblc on 28.10.2020.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet private weak var articleTextView: UITextView!
    @IBOutlet private weak var articleImageView: UIImageView!

    func load(with model: ArticleModel) {
        self.articleTextView.text = model.text
        let url = URL(string: model.image)
        self.articleImageView.kf.setImage(with: url)
        self.setupShadow()

    }

}

extension UIView {
    func setupShadow() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
   }
}
