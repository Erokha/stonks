import UIKit
import PinLayout

final class SecondPageViewController: UIViewController {

    weak var delegate: PageControllerDelegate?

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
    }

    private func updateNextButton() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func setupView() {
        view.backgroundColor = Constants.backgroundColor
    }

    private func setupSubviews() {
        setupNextButton()
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
        layoutNextButton()
    }

    private func layoutNextButton() {
        nextButton.pin
            .hCenter()
            .width(90%)
            .height(50)
            .bottom(10%)
    }

    @objc
    private func didTapNextButton() {
        delegate?.showNextPage()
    }}

extension SecondPageViewController {
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

            static let title: String = "Next"

            static let fontColor: UIColor = .white

            static let topSpacingMultiplier: CGFloat = 0.05

            static let widthPercent: Percent = 90%

            static let heightConstant: CGFloat = 55
        }
    }
}
