
import UIKit

extension UILabel {
    convenience init(text: String = "",
                     fontSize: CGFloat,
                     textColor: UIColor? = Resources.Colors.mainColor,
                     textAligment:  NSTextAlignment = .natural) {
        self.init(frame: .zero)
        self.textColor = textColor
        self.textAlignment = textAligment
        self.text = text
        self.font = .boldSystemFont(ofSize: fontSize)
    }
}
