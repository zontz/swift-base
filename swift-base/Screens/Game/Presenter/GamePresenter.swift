
import UIKit

protocol GameModuleOutput: AnyObject {
    /// Notify that game is ended
    func gameIsEnd(with game: Game)
}

protocol GameModuleInput: AnyObject {}

final class GamePresenter: GameModuleInput {

    // MARK: - Propertie
    
    weak var view: GameViewInput?
    var router: GameRouterInput?
    var output: GameModuleOutput?
    
    private let archiver: ArchiverInput
    private var questionService: QuestionServiceInput
    private let category: Category

    // MARK: - Lifecycle

    init(router: GameRouterInput,
         with category: Category,
         arciver: ArchiverInput,
         questionService: QuestionServiceInput) {
        self.router = router
        self.category = category
        self.archiver = arciver
        self.questionService = questionService
    }
    
    // MARK: - Private methods
    
    private func checkIsLastQuestion() {
        if questionService.questions.count == 0 {
            showResultPopUpView()
        } else {
            questionService.nextQuestion()
            view?.updateQuestion(questionService.currentQuestion)
        }
        questionService.update()
        view?.updateProgressView(textRightAnswer: questionService.countOfRightAnsweredAndPercent,
                                  textCountQuestion: questionService.countOfQuestionsAnswered,
                                  progress: questionService.progress)
    }

    private func showResultPopUpView() {
        let score = questionService.countOfRightAnswersPerGame
        let totalScore = questionService.rightAnswerIds.count
        let count = questionService.countOfQuestions
        let text = "Вы ответили правильно на \(score)/\(count)\nВаш общий счет: \(totalScore)"
        router?.showPopUpView(output: self,
                              mainText: "Поздравляю",
                              secondText: text,
                              closeButtonText: "Выйти в главное меню")
    }

    private func showHint() {
        router?.showPopUpView(output: self,
                              mainText: "Теория",
                              secondText: questionService.currentQuestion?.hint ?? "",
                              closeButtonText: "Закрыть")
    }

    private func saveGame(game: Game) {
        var games = archiver.loadFromUserDefaults(type: [Game].self, forKey: Keys.game.rawValue)

        games?.insert(game, at: 0)
        archiver.saveFromUserDefaults(data: games, forkey: Keys.game.rawValue)
    }
}

// MARK: - GameViewOutput

extension GamePresenter: GameViewOutput { 
    func viewDidLoad() {
        let score = archiver.loadFromUserDefaults(type: Set<Int>.self, forKey: Keys.score.rawValue) ?? []
        questionService.setup(category: category.key, score: score)
        view?.updateQuestion(questionService.currentQuestion)
        view?.updateProgressView(textRightAnswer: questionService.countOfRightAnsweredAndPercent,
                                  textCountQuestion: questionService.countOfQuestionsAnswered,
                                  progress: questionService.progress)
    }

    func viewWillDisappear() {
        archiver.saveFromUserDefaults(data: questionService.rightAnswerIds, forkey: Keys.score.rawValue)
        let game = Game(date: DateFormatter.getStringFormattedDate,
                        category: category.name,
                        countOfQuestionsAnswered: questionService.countOfQuestionsAnswered,
                        countOfQuestions: questionService.countOfQuestions,
                        score: questionService.countOfRightAnswersPerGame,
                        percent: questionService.percent)
        
        if questionService.questions.count + 1 != questionService.countOfQuestions {
            saveGame(game: game)
        }
        
        output?.gameIsEnd(with: game)
    }

    func answerButtonDidTap(with button: UIButton) {
        guard let title = button.titleLabel?.text else { return }

        let isRightAnswer = questionService.isRightAnswer(textAnswer: title)
        let isHintGame = archiver.loadFromUserDefaults(type: Int.self, forKey: SettingKey.hint.rawValue) == 0

        button.backgroundColor = isRightAnswer ? .green : .red
        view?.playSound(sound: isRightAnswer ? .correctAnswer : .incorrectAnswer)

        if !isRightAnswer && isHintGame {
            questionService.isAnswered = true
            showHint()
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            button.backgroundColor = UIColor(named: "MainColor")
            self.checkIsLastQuestion()
        }
    }
}

// MARK: - PopUpViewOutput

extension GamePresenter: PopUpViewOutput {
    func closeButtonDidTap() {
        router?.showMenuModule()
    }
}

// MARK: - ProgressViewOutput

extension GamePresenter: ProgressViewOutput {
    func hintButtonDidTap() {
        showHint()
    }
}
