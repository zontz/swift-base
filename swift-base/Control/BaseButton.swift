
import UIKit

final class BaseButton: UIButton {

    enum ButtonStyle {
        case normal
        case image
        case category
        case clear
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(style: ButtonStyle, title: String = "", image: UIImage? = UIImage()) {
        self.init(frame: .zero)
        switch style {
        case .image:
            createImageButton(image)
        case .normal:
            createNormalButton(title)
        case .category:
            createCategoryButton(title)
        case .clear:
            createClearButton()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createNormalButton(_ title: String) {
        layer.cornerRadius = 10
        setTitle(title, for: .normal)
        backgroundColor = Resources.Colors.mainColor
        setTitleColor(Resources.Colors.textColor, for: .normal)
    }

    private func createCategoryButton(_ title: String) {
        backgroundColor = .white
        titleLabel?.font = .systemFont(ofSize: 15)
        setTitle(title, for: .normal)
        layer.cornerRadius = 10
    }

    private func createImageButton(_ image: UIImage?) {
        backgroundColor = Resources.Colors.mainColor
        setImage(image, for: .normal)
        tintColor = Resources.Colors.textColor
        layer.cornerRadius = 10
    }

    private func createClearButton() {
        backgroundColor = .clear
    }
}
