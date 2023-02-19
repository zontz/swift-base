
import UIKit

protocol GameViewOutput: AnyObject {
    /// Notify that view has loaded
    func viewDidLoad()
    /// Notify that view will disappear
    func viewWillDisappear()
    /// Notify to handle answer button click
    func answerButtonDidTap(with button: UIButton)
}

protocol GameViewInput: AnyObject {
    /// Update screen with new question
    func updateQuestion(_ question: Question?)
    /// Update progress view after question answered
    func updateProgressView(textRightAnswer: String, textCountQuestion: String, progress: Float)
    /// Play win or lose music
    func playSound(sound: Sound)
}

final class GameViewController: UIViewController, ModuleTransitionable {

    // MARK: - Properties

    var output: GameViewOutput

    // MARK: - UI
    
    private let progressView: GameProgressView

    private lazy var questionLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackViewContainer = UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 10)
    private lazy var stackViewQuestion = UIStackView(axis: .vertical, distribution: .fillEqually)
    private lazy var stackViewAnswer = UIStackView(axis: .vertical, distribution: .fillEqually, spacing: 10)
    
    // MARK: - Life Cycle

    init(output: GameViewOutput, progressView: GameProgressView) {
        self.output = output
        self.progressView = progressView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViews()
        setupConstraints()
        output.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output.viewWillDisappear()
    }
    
    // MARK: - Private methods

    private func setup() {
        view.backgroundColor = .systemGray6

        stackViewQuestion.backgroundColor = .white
        stackViewQuestion.layer.cornerRadius = 16
    }

    private func createAnswerButton(_ title: String) -> BaseButton {
        let button = BaseButton(style: .normal, title: title)
        button.addTarget(self, action: #selector(answerButtonDidTap), for: .touchUpInside)
        return button
    }
    
    //MARK: - Action

    @objc
    private func answerButtonDidTap(_ sender: UIButton) {
        output.answerButtonDidTap(with: sender)
    }
}

// MARK: - Layout

extension GameViewController {
    struct Layout {
        static let progressViewTopInset = 10
        static let progressViewRightLeftInset = 16

        static let stackViewContainerRightLeftBottomInset = 16
        static let stackViewContainerTopOffset = 16

        static let questionLabelLeftRightInset = 10
    }

    private func setupViews() {
        view.addSubview(progressView)
        view.addSubview(stackViewContainer)

        stackViewContainer.addArrangedSubview(stackViewQuestion)
        stackViewContainer.addArrangedSubview(stackViewAnswer)

        stackViewQuestion.addArrangedSubview(questionLabel)
    }

    private func setupConstraints() {
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.progressViewTopInset)
            make.right.left.equalToSuperview().inset(Layout.progressViewRightLeftInset)
        }

        stackViewContainer.snp.makeConstraints { make in
            make.right.bottom.left.equalToSuperview().inset(Layout.stackViewContainerRightLeftBottomInset)
            make.top.equalTo(progressView.snp.bottom).offset(Layout.stackViewContainerTopOffset)
        }
        questionLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.questionLabelLeftRightInset)
        }
    }
}

// MARK: - GameViewInput

extension GameViewController: GameViewInput {

    func playSound(sound: Sound) {
        SoundManager.shared.playSound(sound: sound)
    }
    
    func updateQuestion(_ question: Question?) {

        guard let question = question else { return }

        stackViewAnswer.subviews.forEach { $0.removeFromSuperview() }
        stackViewQuestion.subviews.forEach { $0.removeFromSuperview() }

        questionLabel.text = question.textQuestion
        stackViewQuestion.addArrangedSubview(questionLabel)

        question.answers.forEach{ stackViewAnswer.addArrangedSubview(createAnswerButton($0.textAnswer)) }
    }

    func updateProgressView(textRightAnswer: String, textCountQuestion: String, progress: Float) {
        progressView.update(textRightAnswer: textRightAnswer,
                             textCountQuestion: textCountQuestion,
                             progress: progress)
    }
}
