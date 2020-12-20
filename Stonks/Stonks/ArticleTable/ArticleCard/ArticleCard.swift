import UIKit
import Kingfisher
import SafariServices
import PinLayout

class ArticleTableViewCell: UITableViewCell {

    private var articleTextView = UILabel()
    private var articleImageView = UIImageView()
    private var articleReadMoreButton = UIButton()
    weak var output: ArticleViewOutput?

    private var url: URL?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = Constants.backgroundColor
        setupReadMoreButton()
        setupImage()
        setupTextView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUI()
    }

    private func layoutUI() {
        layoutView()
        layoutImage()
        layoutTextView()
        layoutReadMoreButton()
    }

    private func setupImage() {
        contentView.addSubview(articleImageView)

        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
    }

    private func setupReadMoreButton() {
        contentView.addSubview(articleReadMoreButton)

        articleReadMoreButton.addTarget(self, action: #selector(didTapReadMoreButton), for: .touchUpInside)
        articleReadMoreButton.titleLabel?.font = Constants.Buttons.font
        articleReadMoreButton.setTitleColor(Constants.tintColor, for: .normal)
        articleReadMoreButton.setTitle("Read More", for: .normal)
    }

    private func setupTextView() {
        contentView.addSubview(articleTextView)

        articleTextView.font = Constants.Label.font
        articleTextView.lineBreakMode = .byTruncatingTail
        articleTextView.contentMode = .center
        articleTextView.numberOfLines = Constants.Label.numberOfLines
    }

    private func layoutReadMoreButton() {
        articleReadMoreButton.pin
            // .width(Constants.Buttons.width)
            .sizeToFit()// height(10)

        articleReadMoreButton.pin
            .right(Constants.Buttons.rightPin)
            .below(of: articleTextView).margin(Constants.topVerticalSpacing)
    }

    private func layoutImage() {
        articleImageView.pin
            .left()
            .right()
            .top()
            .height(Constants.Image.height)
    }

    private func layoutTextView() {
        articleTextView.pin
            .left(Constants.Label.left)
            .right(Constants.Label.right)
            .below(of: articleImageView).margin(Constants.Label.topSpace)
            .height(Constants.Label.height)
    }

    func load(with model: ArticleModel, output: ArticleViewOutput?) {
        self.articleTextView.text = model.text
        let imageUrl = URL(string: model.image)
        self.articleImageView.kf.setImage(with: imageUrl)
        self.url = URL(string: model.url)
        self.output = output
        self.setupShadow()
    }

    private func layoutView() {
        self.pin
            .left(10)
            .right(10)
    }

    @objc private func didTapReadMoreButton(_ sender: Any) {
        output?.didTapReadMore(url: url)
    }

}

extension ArticleTableViewCell {
    func setupShadow() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
   }
}

extension ArticleTableViewCell {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateViewColor()
    }

    private func updateViewColor() {
        self.backgroundColor = Constants.backgroundColor
    }
}

extension ArticleTableViewCell {
    private struct Constants {
        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 72 / 255,
                               green: 69 / 255,
                               blue: 84 / 255,
                               alpha: 1)
            } else {
                return UIColor(red: 254 / 255,
                               green: 254 / 255,
                               blue: 254 / 255,
                               alpha: 1)
            }
        }

        static let tintColor: UIColor = UIColor(red: 113 / 255,
                                                green: 101 / 255,
                                                blue: 227 / 255,
                                                alpha: 1)

        static let topVerticalSpacing: CGFloat = 3

        struct Buttons {
            static let font: UIFont? = UIFont(name: "DMSans-Medium", size: 16)

            static let width: CGFloat = 74

            static let height: CGFloat = 30

            static let rightPin: CGFloat = 21
        }

        struct Image {
            static let height: Percent = 57%
        }

        struct Label {
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 14)

            static let numberOfLines: Int = 3

            static let left: CGFloat = 5

            static let right: CGFloat = 5

            static let topSpace: CGFloat = 12

            static let height: CGFloat = 60
        }
    }
}
