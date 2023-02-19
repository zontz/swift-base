
import UIKit

extension UIProgressView {
    convenience init(tintColor: UIColor? = Resources.Colors.mainColor,
                     progress: Float = 0,
                     trackTintColor: UIColor = .white) {
        self.init(frame: .zero)
        self.progressTintColor = tintColor
        self.progress = progress
        self.trackTintColor = trackTintColor
    }
}
