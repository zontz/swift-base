
import UIKit

final class HeaderCategoryScreenView: UIView {

    // MARK: - UI

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Логические операторы"
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.text = "Тема закреплена на: 0%"
        return label
    }()
    private lazy var countOfQuestionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.black
        label.text = "Вопросов: 7"
        return label
    }()

    private lazy var horizontalStackView = UIStackView(axis: .horizontal, distribution: .equalSpacing)
    private lazy var verticalStackView = UIStackView(axis: .vertical)

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup(){
        backgroundColor = .systemGray6
    }

    // MARK: - Public Methods

    /// Configure headerView with category
    func updateHeaderView(with game: Game) {        
        categoryLabel.text = game.category
        
        let percentText = NSMutableAttributedString(string:"Тема закреплена на: \(String(format:"%.1f", game.percent*100))%")
        percentText.setColorForText("\(game.percent*100)%", with: UIColor.green)
        percentLabel.attributedText = percentText
        
        let countQuestionText = NSMutableAttributedString(string:"Вопросов: \(game.countOfQuestions)")
        countQuestionText.setColorForText("\(game.countOfQuestions)", with: UIColor.green)
        countOfQuestionsLabel.attributedText = countQuestionText
    }
}

// MARK: - Layout

extension HeaderCategoryScreenView {
    struct Layout {
        static let verticalStackViewLeftRightInset = 16
    }

    private func setupViews() {
        addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(categoryLabel)
        verticalStackView.addArrangedSubview(horizontalStackView)

        horizontalStackView.addArrangedSubview(percentLabel)
        horizontalStackView.addArrangedSubview(countOfQuestionsLabel)
    }

    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(Layout.verticalStackViewLeftRightInset)
        }
    }
}
