
import UIKit

protocol HistoryHeaderViewOutput: AnyObject {
    /// Notify to handle trash button click
    func trashButtonDidTap()
}

final class HistoryHeaderView: UIView {

    // MARK: - Properties

    weak var output: HistoryHeaderViewOutput?

    // MARK: - UI

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Исторя игр"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(named: "TextColor")
        return label
    }()

    private lazy var trashBinButton = BaseButton(style: .image, image: UIImage(systemName: "trash"))
    private lazy var mainHorizontalStackView = UIStackView(axis: .horizontal)

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
        backgroundColor = .systemGray6
    }

    private func setupBehavior() {
        trashBinButton.addTarget(self, action: #selector(trashButtonDidTap), for: .touchUpInside)
        trashBinButton.backgroundColor = .clear
    }

    // MARK: - Actions
    
    @objc
    private func trashButtonDidTap() {
        output?.trashButtonDidTap()
    }
}

// MARK: - Layout

extension HistoryHeaderView {
    struct Layout {
        static let mainHorizontalStackViewBottomLeftRightInset = 16
        static let mainHorizontalStackViewTopInset = 8

        static let trashBinButtonWidthHeight = 30
    }

    private func setupViews() {
        addSubview(mainHorizontalStackView)

        mainHorizontalStackView.addArrangedSubview(categoryLabel)
        mainHorizontalStackView.addArrangedSubview(trashBinButton)
    }

    private func setupConstraints() {
        mainHorizontalStackView.snp.makeConstraints { make in
            make.bottom.right.left.equalToSuperview().inset(Layout.mainHorizontalStackViewBottomLeftRightInset)
            make.top.equalToSuperview().inset(Layout.mainHorizontalStackViewTopInset)
        }

        trashBinButton.snp.makeConstraints { make in
            make.width.height.equalTo(Layout.trashBinButtonWidthHeight)
        }
    }
}
