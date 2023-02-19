
import UIKit

protocol CurrentCategoryViewOutput: AnyObject {
    /// Notify to handle category button click
    func categoryButtonDidTap()
}

final class CurrentCategoryView: UIView {

    // MARK: - Properties

    weak var output: CurrentCategoryViewOutput?

    // MARK: - UI

    private lazy var clearButton = BaseButton(style: .clear)

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Текущая категория:"
        return label
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "Логические операторы"
        return label
    }()

    private lazy var categoryVerticalStackView = UIStackView(axis: .vertical, spacing: 2)

    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        setupBehavior()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }

    private func setupBehavior() {
        clearButton.addTarget(self, action: #selector(categoryButtonDidTap), for: .touchUpInside)
    }

    // MARK: - Public methods

    /// Update new category
    func updateCurrentCategory(with category: String) {
        categoryLabel.text = category == "" ? "Логические операторы" : category
    }

    // MARK: - Actions

    @objc
    private func categoryButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output?.categoryButtonDidTap()
    }
}

// MARK: - Layout

extension CurrentCategoryView {
    struct Layout {
        static let categoryVerticalStackViewTopInset = 5
    }

    private func setupViews() {
        addSubview(categoryVerticalStackView)
        addSubview(clearButton)

        categoryVerticalStackView.addArrangedSubview(mainLabel)
        categoryVerticalStackView.addArrangedSubview(categoryLabel)
    }

    private func setupConstraints() {
        clearButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        categoryVerticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.categoryVerticalStackViewTopInset)
            make.centerX.equalToSuperview()
        }
    }
}
