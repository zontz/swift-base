
import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis,
                     distribution: UIStackView.Distribution = .fill,
                     spacing: CGFloat = 0) {
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
    }
}
