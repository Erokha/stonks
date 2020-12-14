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
            .top(15%)
            .left(5%)
            .width(45%)
            .height(15%)
    }

    private func layoutUpperTextRight() {
        upperTextRight.pin
            .top(15%)
            .right(5%)
            .width(45%)
            .height(15%)
    }

    private func layoutLeftButton() {
        leftButton.pin
            .width(15)
            .height(15)

        leftButton.pin
            .left(numberLeft.frame.minX - 5 - leftButton.bounds.width)
            .top(numberLeft.frame.midY - leftButton.bounds.height / 2)
    }

    private func layoutRightButton() {
        rightButton.pin
            .width(15)
            .height(15)

        rightButton.pin
            .left(numberRight.frame.minX - 5 - rightButton.bounds.width)
            .top(numberRight.frame.midY - rightButton.bounds.height / 2)
    }

    private func layoutNumberLeft() {
        numberLeft.pin
            .sizeToFit()

        numberLeft.pin
            .left(upperTextLeft.frame.midX - numberLeft.bounds.width / 2)
            .top(upperTextLeft.frame.maxY + 12)
    }

    private func layoutNumberRight() {
        numberRight.pin
            .sizeToFit()

        numberRight.pin
            .left(upperTextRight.frame.midX - numberRight.bounds.width / 2)
            .top(upperTextRight.frame.maxY + 12)
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

        leftButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        leftButton.tintColor = UIColor(red: 113 / 255,
                                       green: 101 / 255,
                                       blue: 227 / 255,
                                       alpha: 1)
        leftButton.contentMode = .scaleToFill
    }

    private func setupRightButton() {
        let button = UIButton()

        rightButton = button
        addSubview(rightButton)

        rightButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        rightButton.tintColor = .red
        rightButton.contentMode = .scaleToFill
    }

    private func setupNumberLeft() {
        let label = UILabel()

        numberLeft = label
        addSubview(numberLeft)

        numberLeft.textAlignment = .center
        numberLeft.font = UIFont(name: "DMSans-Bold", size: 22)
    }

    private func setupNumberRight() {
        let label = UILabel()

        numberRight = label
        addSubview(numberRight)

        numberRight.textAlignment = .center
        numberRight.font = UIFont(name: "DMSans-Bold", size: 22)
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
            static let font: UIFont? = UIFont(name: "DMSans-Medium", size: 13)
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
