
import UIKit

final class HistoryTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifire = "HistoryTableViewCell"
    private let historyView = HistoryPercentView()

    // MARK: - UI

    private lazy var categoryLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(named: "TextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var countOfQuestionsLabel: UILabel = {
        var label = UILabel()
        label.textColor =  UIColor(named: "TextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
        var label = UILabel()
        label.textColor =  UIColor(named: "TextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    private lazy var separatorView = BaseView(style: .separator)
    private lazy var scoreAndQuestionHorizontalStackView = UIStackView(axis: .horizontal, spacing: 10)
    private lazy var mainVerticalStackView = UIStackView(axis: .vertical, spacing: 10)
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setup() {
        backgroundColor = UIColor(named: "BackgroundColor")
    }

    // MARK: - Public Methods

    /// Configure cell with data
    func configure(with game: Game) {
        historyView.update(with: game.percent)
        categoryLabel.text = game.category
        scoreLabel.text = "Очки: \(String(game.score))"
        dateLabel.text = "Дата: \(game.date)"
        countOfQuestionsLabel.text = "Вопросы: \(game.countOfQuestionsAnswered)"
    }
}

// MARK: - Layout

extension HistoryTableViewCell {
    struct Layout {
        static let historyViewHeightAndWidth = 70
        static let historyViewTopInset = 5
        static let historyViewLeftInset = 10

        static let mainVerticalStackViewLeftOffset = 10
        static let mainVerticalStackViewRightInset = 10
        static let mainVerticalStackViewBottomInset = 5

        static let separatorViewHeight = 1
    }

    private func setupViews() {
        contentView.addSubview(historyView)
        contentView.addSubview(mainVerticalStackView)

        mainVerticalStackView.addArrangedSubview(categoryLabel)
        mainVerticalStackView.addArrangedSubview(dateLabel)
        mainVerticalStackView.addArrangedSubview(scoreAndQuestionHorizontalStackView)
        mainVerticalStackView.addArrangedSubview(separatorView)

        scoreAndQuestionHorizontalStackView.addArrangedSubview(countOfQuestionsLabel)
        scoreAndQuestionHorizontalStackView.addArrangedSubview(scoreLabel)
    }

    private func setupConstraints() {
        historyView.snp.makeConstraints { make in
            make.height.width.equalTo(Layout.historyViewHeightAndWidth)
            make.top.equalToSuperview().inset(Layout.historyViewTopInset)
            make.left.equalToSuperview().inset(Layout.historyViewLeftInset)
        }

        mainVerticalStackView.snp.makeConstraints { make in
            make.top.equalTo(historyView.snp.top)
            make.left.equalTo(historyView.snp.right).offset(Layout.mainVerticalStackViewLeftOffset)
            make.right.equalToSuperview().inset(Layout.mainVerticalStackViewRightInset)
            make.bottom.equalToSuperview().inset(Layout.mainVerticalStackViewBottomInset)
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(Layout.separatorViewHeight)
        }
    }
}
