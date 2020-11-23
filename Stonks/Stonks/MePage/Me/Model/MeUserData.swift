import UIKit

struct MeUserData {
    var name: String
    var surname: String
    var avatar: UIImage?
    var balance: Int
    var totalSpent: Int

    init(with user: User) {
        self.name = user.name
        self.surname = user.surname
        if let documentURL = FileManager.default.urls(for: .documentDirectory,
                                                      in: .userDomainMask).first {
            let newurl = documentURL.appendingPathComponent("avatar.png")
            if let avatarImage = UIImage(contentsOfFile: newurl.path) {
                self.avatar = avatarImage
            }
        }
//        let imageUrl = user.avatarURL
//        if let avatarImage = UIImage(contentsOfFile: imageUrl.path ?? "") {
//            self.avatar = avatarImage
//        }
        let balance = Float(truncating: user.balance)
        self.balance = Int(balance)
        let totalSpent = Float(truncating: user.totalSpent)
        self.totalSpent = Int(totalSpent)

    }
}
