import UIKit
import PinLayout

extension LoginViewController {
    internal struct Constants {
        static var defaultStyleEntriesColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 72 / 255,
                               green: 69 / 255,
                               blue: 84 / 255,
                               alpha: 1)
            } else {
                return UIColor(red: 250 / 255,
                               green: 250 / 255,
                               blue: 250 / 255,
                               alpha: 1)
            }
        }

        static let editingStyleEntriesBorderColor: UIColor = UIColor(red: 113 / 255,
                                                                     green: 101 / 255,
                                                                     blue: 227 / 255,
                                                                     alpha: 1)

        static var editingStyleEntriesColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return UIColor(red: 113 / 255,
                               green: 101 / 255,
                               blue: 227 / 255,
                               alpha: 0.4)
            } else {
                return UIColor(red: 113 / 255,
                               green: 101 / 255,
                               blue: 227 / 255,
                               alpha: 0.2)
            }
        }

        static let screenHeight: CGFloat = UIScreen.main.bounds.height

        static let screenWidth: CGFloat = UIScreen.main.bounds.width

        static let textFieldFont: UIFont? = UIFont(name: "DMSans-Regular", size: 15)

        static let textFieldCornerRadius: CGFloat = 10

        static let textFieldBorderWidth: CGFloat = 1

        static var textFieldPlaceholderColor: UIColor {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return .white
            } else {
                return .black
            }
        }

        static let textFieldTextLeftSpacing: CGFloat = 10

        static let textFieldTextRightSpacing: CGFloat = 10

        static let textFieldHeightConstant: CGFloat = 48

        static let textFieldWidthPercent: Percent = 90%

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

        struct WelcomeLabel {
            static let text: String = "Welcome!"

            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 35)

            static let topPercent: Percent = 16.5%

            static let widthPercent: Percent = 50%

            static let height: CGFloat = 50
        }

        struct NameTextField {
            static let placeholderText = String(repeating: " ", count: 4) + "Name"

            static let topSpacingMultiplier: CGFloat = 0.098
        }

        struct SurnameTextField {
            static let placeholderText = String(repeating: " ", count: 4) + "Surname"

            static let topSpacingMultiplier: CGFloat = 0.012
        }

        struct BalanceTextField {
            static let placeholderText = String(repeating: " ", count: 4) + "Start Balance"

            static let topSpacingMultiplier: CGFloat = 0.012
        }

        struct CheckBoxDescriptionLabel {
            static let font: UIFont? = UIFont(name: "DMSans-Regular", size: 13)

            static let text: String = "By creating your account you have to agree with our Terms and Conditions"

            static let leftSpacingMultiplier: CGFloat = 0.05

            static let rightPercent: Percent = 5%

            static let heightConstant: CGFloat = 45
        }

        struct RegisterButton {
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

            static let title: String = "Look through"

            static let fontColor: UIColor = .white

            static let topSpacingMultiplier: CGFloat = 0.05

            static let widthPercent: Percent = 90%

            static let heightConstant: CGFloat = 55
        }

        struct CheckBoxImageView {
            static var checkBoxIsCheckedImageName: String {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return "checkBoxCheckedDark"
                } else {
                    return "checkBoxCheckedLight"
                }
            }

            static let checkBoxNotCheckedImageName: String = "checkBoxNotChecked"

            static let recognizerTapsRequired: Int = 1

            static let topSpacingMultiplier: CGFloat = 0.035

            static let leftPercent: Percent = 5%
        }

        struct SignInSeparatorLabel {
            static let text: String = "or"

            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 14)

            static let topSpacingMultiplier: CGFloat = 0.02

            static let widthPercent: Percent = 10%

            static let height: CGFloat = 48
        }

        struct SeparatorView {
            static let sideOffsetPercent: Percent = 33%

            static let widthPercent: Percent = 10%

            static let height: CGFloat = 1

            static var backgroundColor: UIColor {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return .white
                } else {
                    return .black
                }
            }
        }

        struct GoogleSignInButton {
            static let title: String = "Sign In with Google"

            static let font: UIFont? = UIFont(name: "DMSans-Bold", size: 14)

            static let cornerRadius: CGFloat = 15

            static let shadowRadius: CGFloat = 2

            static let shadowOffset: CGSize = CGSize(width: 0, height: 3)

            static let shadowColor: UIColor = .black

            static var titleColor: UIColor {
                if UITraitCollection.current.userInterfaceStyle == .dark {
                    return .white
                } else {
                    return .black
                }
            }

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

            static let shadowOpacity: Float = 0.4

            static let imageName: String = "google_logo"

            static let topSpacingMultiplier: CGFloat = 0.015

            static let widthPercent: Percent = 70%

            static let height: CGFloat = 48

            static let imageScale: CGFloat = 0.4

            static let imageLeftPercent: Percent = 5%
        }

        struct TapRecognizer {
            static let tapsRequired: Int = 1
        }
    }
}
