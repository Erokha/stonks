import UIKit
import PinLayout

final class NewCardView: UIView {
    var presenter: CardViewPresenterType!

    private weak var upperTextLeft: UILabel!

    private weak var upperTextRight: UILabel!

    private weak var leftButton: UIButton!

    private weak var rightButton: UIButton!

    private weak var numberLeft: UILabel!

    private weak var numberRight: UILabel!

    init() {
        super.init(frame: .zero)

        setupView()
        setupSubviews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layoutUpperTextLeft()
        layoutUpperTextRight()
        layoutNumberLeft()
        layoutLeftButton()
        layoutNumberRight()
        layoutRightButton()
    }

    private func setupView() {
        backgroundColor = Constants.backgroundColor
    }

    private func layoutUpperTextLeft() {
        upperTextLeft.pin
            .top(Constants.UpperLabel.topPercent)
            .left(Constants.UpperLabelLeft.leftPercent)
            .width(Constants.UpperLabel.widthPercent)
            .height(Constants.UpperLabel.heightPercent)
    }

    private func layoutUpperTextRight() {
        upperTextRight.pin
            .top(Constants.UpperLabel.topPercent)
            .right(Constants.UpperLabelRight.rightPercent)
            .width(Constants.UpperLabel.widthPercent)
            .height(Constants.UpperLabel.heightPercent)
    }

    private func layoutLeftButton() {
        leftButton.pin
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.width)

        leftButton.pin
            .left(numberLeft.frame.minX - Constants.screenWidth * Constants.Buttons.spacingFromLabelMultiplier - Constants.Buttons.width)
            .top(numberLeft.frame.midY - leftButton.bounds.height / 2)
    }

    private func layoutRightButton() {
        rightButton.pin
            .width(Constants.Buttons.width)
            .height(Constants.Buttons.width)

        rightButton.pin
            .left(numberRight.frame.minX - Constants.screenWidth * Constants.Buttons.spacingFromLabelMultiplier - Constants.Buttons.width)
            .top(numberRight.frame.midY - rightButton.bounds.height / 2)
    }

    private func layoutNumberLeft() {
        numberLeft.pin
            .sizeToFit()

        numberLeft.pin
            .left(upperTextLeft.frame.midX - numberLeft.bounds.width / 2)
            .top(upperTextLeft.frame.maxY + Constants.screenWidth * Constants.NumberLabel.topSpacingMupltiplier)
    }

    private func layoutNumberRight() {
        numberRight.pin
            .sizeToFit()

        numberRight.pin
            .left(upperTextRight.frame.midX - numberRight.bounds.width / 2)
            .top(upperTextRight.frame.maxY + Constants.screenWidth * Constants.NumberLabel.topSpacingMupltiplier)
    }

    private func setupSubviews() {
        setupUpperTextLeft()
        setupUpperTextRight()
        setupLeftButton()
        setupRightButton()
        setupNumberLeft()
        setupNumberRight()
    }

    private func setupUpperTextLeft() {
        let label = UILabel()

        upperTextLeft = label
        addSubview(upperTextLeft)

        upperTextLeft.textAlignment = .center
        upperTextLeft.font = Constants.UpperLabel.font
    }

    private func setupUpperTextRight() {
        let label = UILabel()

        upperTextRight = label
        addSubview(upperTextRight)

        upperTextRight.textAlignment = .center
        upperTextRight.font = Constants.UpperLabel.font
    }

    private func setupLeftButton() {
        let button = UIButton()

        leftButton = button
        addSubview(leftButton)

        leftButton.setImage(UIImage(systemName: Constants.Buttons.systemImageName), for: .normal)
        leftButton.tintColor = Constants.LeftButton.tintColor
        leftButton.contentMode = .scaleToFill
        leftButton.isUserInteractionEnabled = false
    }

    private func setupRightButton() {
        let button = UIButton()

        rightButton = button
        addSubview(rightButton)

        rightButton.setImage(UIImage(systemName: Constants.Buttons.systemImageName), for: .normal)
        rightButton.tintColor = Constants.RightButton.tintColor
        rightButton.contentMode = .scaleToFill
        rightButton.isUserInteractionEnabled = false
    }

    private func setupNumberLeft() {
        let label = UILabel()

        numberLeft = label
        addSubview(numberLeft)

        numberLeft.textAlignment = .center
        numberLeft.font = Constants.NumberLabel.font
    }

    private func setupNumberRight() {
        let label = UILabel()

        numberRight = label
        addSubview(numberRight)

        numberRight.textAlignment = .center
        numberRight.font = Constants.NumberLabel.font
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewCardView: CardViewType {
    func showUpperTextLeft(text: String) {
        upperTextLeft.text = text
    }

    func showUpperTextRight(text: String) {
        upperTextRight.text = text
    }

    func showNumberLeft(num: Int?) {
        self.numberLeft.text = String.adoptStonksCardPrice(with: num)
        setNeedsLayout()
        layoutIfNeeded()
    }

    func showNumberRight(num: Int?) {
        self.numberRight.text = String.adoptStonksCardPrice(with: num)
        setNeedsLayout()
        layoutIfNeeded()
    }
}

extension NewCardView {
    private struct Constants {
        static let screenWidth: CGFloat = UIScreen.main.bounds.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static var backgroundColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 71 / 255,
                               green: 68 / 255,
                               blue: 83 / 255,
                               alpha: 1)
            } else {
                return .white
            }
        }

        struct UpperLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Medium", size: 12)

            static let topPercent: Percent = 18%

            static let widthPercent: Percent = 45%

            static let heightPercent: Percent = 15%
        }

        struct UpperLabelLeft {
            static let leftPercent: Percent = 5%
        }

        struct UpperLabelRight {
            static let rightPercent: Percent = 5%
        }

        struct Buttons {
            static let systemImageName: String = "circle.fill"

            static let width: CGFloat = 15

            static let height: CGFloat = 15

            static let spacingFromLabelMultiplier: CGFloat = 0.015
        }

        struct LeftButton {
            static let tintColor: UIColor = UIColor(red: 113 / 255,
                                                    green: 101 / 255,
                                                    blue: 227 / 255,
                                                    alpha: 1)

        }

        struct RightButton {
            static let tintColor: UIColor = .red
        }

        struct NumberLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 22)

            static let topSpacingMupltiplier: CGFloat = 0.025
        }
    }
}

extension String {
    static func adoptStonksCardPrice(with num: Int?) -> String {
        guard let number = num else { return "" }
        if number >= 1000000000 {
            let res = String(format: "%.1f", Float(number) / 1000000000)
            return "$\(res)B"
        } else if number >= 1000000 {
            let res = String(format: "%.1f", Float(number) / 1000000)
            return "$\(res)M"
        } else if number >= 100000 {
            let res = String(format: "%.2f", Float(number) / 1000)
            return "$\(res)k"
        } else {
            return "$\(number)"
        }
    }
}
