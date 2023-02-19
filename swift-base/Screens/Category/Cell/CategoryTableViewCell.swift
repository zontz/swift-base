
import UIKit

protocol CategoryTableViewCellOutput: AnyObject {
    /// Notify to handle category button click
    func categoryButtonDidTap(_ category: Category)
}

final class CategoryTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifire = "CategoryTableViewCell"

    weak var output: CategoryTableViewCellOutput?

    private lazy var categorys: [Category] = []

    // MARK: - UI

    private lazy var mainHorizontalStackView = UIStackView(axis: .horizontal, distribution: .fillProportionally, spacing: 5)
    
    //MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        mainHorizontalStackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods

    private func setup() {
        backgroundColor = .systemGray6
    }

    private func createButton(_ category: Category) -> BaseButton {
        let button = BaseButton(style: .category, title: category.name)
        button.setTitleColor(category.isEnable ? UIColor.black : UIColor.lightGray, for: .normal)
        button.isUserInteractionEnabled = category.isEnable ? true : false
        button.addTarget(self, action: #selector(categoryButtonDidTap), for: .touchUpInside)
        return button
    }

    // MARK: - Public methods

    func configure(with categorys: [Category]) {
        self.categorys = categorys
        categorys.forEach{ mainHorizontalStackView.addArrangedSubview(createButton($0)) }
    }
    
    // MARK: - Actions
    
    @objc
    private func categoryButtonDidTap(sender: UIButton) {
        SoundManager.shared.playSound(sound: .click)
        let find = categorys.first{$0.name == (sender.titleLabel?.text ?? "")}
        guard let category = find else {return}
        output?.categoryButtonDidTap(category)
    }
}

// MARK: - Layout

extension CategoryTableViewCell {
    struct Layout {
        static let mainHorizontalStackViewLeftRightInset = 16
        static let mainHorizontalStackViewTopBottomInset = 6
    }

    private func setupViews() {
        contentView.addSubview(mainHorizontalStackView)
    }

    private func setupConstraints() {
        mainHorizontalStackView.snp.makeConstraints { make in
            make.left.right.equalTo(safeAreaLayoutGuide).inset(Layout.mainHorizontalStackViewLeftRightInset)
            make.top.bottom.equalTo(safeAreaLayoutGuide).inset(Layout.mainHorizontalStackViewTopBottomInset)
        }
    }
}
