
import UIKit

final class BaseView: UIView {

    enum ViewStyle {
        case separator
        case container
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(style: ViewStyle, title: String = "", image: UIImage? = UIImage()) {
        self.init(frame: .zero)
        switch style {
        case .container: createContainerView()
        case .separator: createSeparatorView()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSeparatorView() {
        backgroundColor = UIColor.black.withAlphaComponent(0.2)
    }

    private func createContainerView() {
        backgroundColor = .white
        layer.cornerRadius = 24
    }
}
