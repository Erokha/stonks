import UIKit
import PinLayout

final class ThirdPageViewController: UIViewController {

    weak var delegate: PageControllerDelegate?

    private weak var imageContainerView: UIView!

    private weak var imageView: UIImageView!

    private weak var mainTitleLabel: UILabel!

    private weak var subtitleLabel: UILabel!

    private weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSubviews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        layoutSubviews()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUI()
    }

    private func updateUI() {
        updateNextButton()
        updateImageContainerView()
        updateImageView()
    }

    private func updateNextButton() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func updateImageContainerView() {
        imageContainerView.backgroundColor = Constants.ImageContainerView.backgroundColor
    }

    private func updateImageView() {
        imageView.image = UIImage(named: Constants.ImageView.imageName)
    }

    private func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func setupSubviews() {
        setupImageContainerView()
        setupImageView()
        setupMainTitleLabel()
        setupSubtitileLabel()
        setupNextButton()
    }

    private func setupImageContainerView() {
        let containerView = UIView()

        imageContainerView = containerView
        view.addSubview(imageContainerView)

        imageContainerView.backgroundColor = Constants.ImageContainerView.backgroundColor
        imageContainerView.layer.cornerRadius = Constants.ImageContainerView.cornerRadius
        imageContainerView.layer.shadowOffset = Constants.ImageContainerView.shadowOffset
        imageContainerView.layer.shadowRadius = Constants.ImageContainerView.shadowRadius
        imageContainerView.layer.shadowColor = Constants.ImageContainerView.shadowColor.cgColor
        imageContainerView.layer.shadowOpacity = Constants.ImageContainerView.shadowOpacity
    }

    private func setupImageView() {
        let image = UIImageView()

        imageView = image
        imageContainerView.addSubview(imageView)

        imageView.image = UIImage(named: Constants.ImageView.imageName)
        imageView.layer.cornerRadius = Constants.ImageView.cornerRadius
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    }

    private func setupMainTitleLabel() {
        let label = UILabel()

        mainTitleLabel = label
        view.addSubview(mainTitleLabel)

        mainTitleLabel.text = Constants.MainTitleLabel.text
        mainTitleLabel.textAlignment = .center
        mainTitleLabel.font = Constants.MainTitleLabel.font
    }

    private func setupSubtitileLabel() {
        let label = UILabel()

        subtitleLabel = label
        view.addSubview(subtitleLabel)

        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.font = Constants.SubtitleLabel.font
        subtitleLabel.text = Constants.SubtitleLabel.text
        subtitleLabel.textAlignment = .center
        subtitleLabel.numberOfLines = .zero
    }

    private func setupNextButton() {
        let button = UIButton()

        nextButton = button
        view.addSubview(nextButton)

        nextButton.backgroundColor = Constants.NextButton.backgroundColor
        nextButton.layer.cornerRadius = Constants.NextButton.cornerRadius
        nextButton.layer.shadowOffset = Constants.NextButton.shadowOffset
        nextButton.layer.shadowRadius = Constants.NextButton.shadowRadius
        nextButton.layer.shadowColor = Constants.NextButton.shadowColor.cgColor
        nextButton.layer.shadowOpacity = Constants.NextButton.shadowOpacity

        nextButton.titleLabel?.font = Constants.NextButton.font
        nextButton.setTitleColor(Constants.NextButton.fontColor, for: .normal)
        nextButton.setTitle(Constants.NextButton.title, for: .normal)

        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }

    private func layoutSubviews() {
        layoutImageContainerView()
        layoutImageView()
        layoutNextButton()
        layoutMainTitleLabel()
        layoutSubtitileLabel()
    }

    private func layoutImageContainerView() {
        imageContainerView.pin
            .top(Constants.ImageContainerView.topPercent)
            .hCenter()
            .width(Constants.ImageContainerView.widthPercent)
            .height(Constants.ImageContainerView.heightPercent)
    }

    private func layoutImageView() {
        imageView.pin
            .all(.zero)
    }

    private func layoutNextButton() {
        nextButton.pin
            .hCenter()
            .width(Constants.NextButton.widthPercent)
            .height(Constants.NextButton.heightConstant)
            .bottom(Constants.NextButton.bottomPercent)
    }

    private func layoutMainTitleLabel() {
        mainTitleLabel.pin
            .top(Constants.MainTitleLabel.topPercent)
            .hCenter()
            .width(Constants.MainTitleLabel.widthPercent)
            .height(Constants.MainTitleLabel.heightConstant)
    }

    private func layoutSubtitileLabel() {
        subtitleLabel.pin
            .top(mainTitleLabel.frame.maxY + Constants.screenHeight * Constants.SubtitleLabel.topSpacingMultiplier)
            .hCenter()
            .width(Constants.SubtitleLabel.widthPercent)
            .height(Constants.SubtitleLabel.heightConstant)
    }

    @objc
    private func didTapNextButton() {
        delegate?.showNextPage()
    }
}

extension ThirdPageViewController {
    private struct Constants {
        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 61 / 255,
                               green: 59 / 255,
                               blue: 69 / 255,
                               alpha: 1)
            } else {
                return .white
            }
        }

        static let screenWidth: CGFloat = UIScreen.main.bounds.width

        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        struct ImageContainerView {
            static let shadowRadius: CGFloat = 2

            static let borderWidth: CGFloat = 1

            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)

            static let shadowColor: UIColor = .black

            static let shadowOpacity: Float = 0.4

            static let cornerRadius: CGFloat = 30

            static var backgroundColor: UIColor {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return UIColor(red: 72 / 255,
                                   green: 69 / 255,
                                   blue: 84 / 255,
                                   alpha: 1)
                } else {
                    return .white
                }
            }

            static let topPercent: Percent = 20%

            static let widthPercent: Percent = 70%

            static let heightPercent: Percent = 30%
        }

        struct ImageView {
            static var imageName: String {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return "darkLearn"
                } else {
                    return "lightLearn"
                }
            }

            static let cornerRadius: CGFloat = 30
        }

        struct NextButton {
            static let cornerRadius: CGFloat = 15

            static let shadowRadius: CGFloat = 2

            static let borderWidth: CGFloat = 1

            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)

            static let shadowColor: UIColor = .black

            static let shadowOpacity: Float = 0.4

            static let backgroundColor: UIColor = UIColor(red: 113 / 255,
                                                          green: 101 / 255,
                                                          blue: 227 / 255,
                                                          alpha: 1)

            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 17)

            static let title: String = "Let's go"

            static let fontColor: UIColor = .white

            static let bottomPercent: Percent = 7%

            static let widthPercent: Percent = 90%

            static let heightConstant: CGFloat = 50
        }

        struct MainTitleLabel {
            static let text: String = "Learn how to"

            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 25)

            static let widthPercent: Percent = 90%

            static let heightConstant: CGFloat = 40

            static let topPercent: Percent = 65%
        }

        struct SubtitleLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 15)

            static let text: String = "Explore fresh trade world news and guides, correct your strategy."

            static let heightConstant: CGFloat = 40

            static let widthPercent: Percent = 60%

            static let topSpacingMultiplier: CGFloat = 0.01
        }
    }
}
