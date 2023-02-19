
import UIKit

extension NSMutableAttributedString{

    /// change color specific text
    static func setTextWithColor(text: String, textWithColor: String, with color: UIColor?) -> NSMutableAttributedString {
        let text = NSMutableAttributedString(string:"\(text)\(textWithColor)")
        text.setColorForText("\(textWithColor)", with: color ?? .clear)
        return text
    }

    /// change color specific text
    func setColorForText(_ textToFind: String, with color: UIColor) {
        let range = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range.location != NSNotFound {
            addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
}
