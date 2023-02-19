
import UIKit

protocol ProgressViewOutput: AnyObject{
    /// Notify to handle hint button click
    func hintButtonDidTap()
}

final class GameProgressView: UIView {

    // MARK: - Properties

    weak var output: ProgressViewOutput?

    // MARK: - UI

    private lazy var countOfRightAnswersAndPercent: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "TextColor")
        label.text = "0 | 0%"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var countOfQuestion: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "TextColor")
        label.text = "0/0"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()

    private lazy var hintButton = BaseButton(style: .image, image: UIImage(systemName: "info.circle"))
    private lazy var progressView = UIProgressView(tintColor: Resources.Colors.mainColor, progress: 0, trackTintColor: .white)
    private lazy var horizontalStackView = UIStackView(axis: .horizontal, distribution: .equalSpacing)
    private lazy var verticalStackView = UIStackView(axis: .vertical, spacing: 10)

    //MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupBehavior()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods

    private func setupBehavior() {
        hintButton.addTarget(self, action: #selector(hintButtonDidTap), for: .touchUpInside)
        hintButton.backgroundColor = .clear
    }

    //MARK: - Action

    @objc
    private func hintButtonDidTap() {
        SoundManager.shared.playSound(sound: .click)
        output?.hintButtonDidTap()
    }
    
    //MARK: - Public methods

    /// Update progressView after answerButtonDidTap
    func update(textRightAnswer: String, textCountQuestion: String, progress: Float) {
        countOfRightAnswersAndPercent.text = textRightAnswer
        countOfQuestion.text = textCountQuestion
        progressView.progress = progress
    }
}

// MARK: - Layout

extension GameProgressView {
    struct Layout {
        static let progressViewHeight = 10
    }

    private func setupViews() {
        addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(horizontalStackView)
        verticalStackView.addArrangedSubview(progressView)

        horizontalStackView.addArrangedSubview(countOfRightAnswersAndPercent)
        horizontalStackView.addArrangedSubview(countOfQuestion)
        horizontalStackView.addArrangedSubview(hintButton)
    }

    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        countOfQuestion.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }

        progressView.snp.makeConstraints { make in
            make.height.equalTo(Layout.progressViewHeight)
        }
    }
}
