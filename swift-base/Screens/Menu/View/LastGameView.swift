
import UIKit

final class LastGameView: UIView {

    // MARK: - UI

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.text = "Информация о прошлой игре:"
        label.textColor = .black
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = ""
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var countOfQuestionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = ""
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var countOfRightAnswersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = ""
        label.textColor = .lightGray
        return label
    }()

    private lazy var gameInfoVerticalStackView = UIStackView(axis: .vertical)

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
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 10
    }

    // MARK: - Public methods

    /// Update new game data
    func updateLastGame(with game: Game) {
        categoryLabel.text = "Категория: \(game.category)"
        countOfQuestionsLabel.text = "Вопросы: \(game.countOfQuestionsAnswered)"
        countOfRightAnswersLabel.text = "Правильных ответов \(game.score)"
    }
}

// MARK: - Layout

extension LastGameView {
    struct Layout {
        static let gameInfoVerticalStackViewEdgesInset = 5
    }

    private func setupViews() {
        addSubview(gameInfoVerticalStackView)

        gameInfoVerticalStackView.addArrangedSubview(mainLabel)
        gameInfoVerticalStackView.addArrangedSubview(categoryLabel)
        gameInfoVerticalStackView.addArrangedSubview(countOfQuestionsLabel)
        gameInfoVerticalStackView.addArrangedSubview(countOfRightAnswersLabel)
    }

    private func setupConstraints() {
        gameInfoVerticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(Layout.gameInfoVerticalStackViewEdgesInset)
        }
    }
}
