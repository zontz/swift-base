import Foundation

protocol QuestionServiceInput {
    /// Array of questions
    var questions: [Question] { get set }
    /// Current question
    var currentQuestion: Question? { get set }
    /// Count of id's that correct answered question
    var rightAnswerIds: Set<Int> { get set }
    /// CountOfQuestions in category
    var countOfQuestions: Int { get set }
    /// Count of questions that answered in gamesession
    var countOfQuestionsAnswered: String { get set }
    /// Percent of right answered questions
    var countOfRightAnsweredAndPercent: String { get set }
    /// Score per game
    var countOfRightAnswersPerGame: Int { get set }
    /// Progress that we will use in progress view
    var progress: Float { get set }
    /// It's for hint game
    var isAnswered: Bool { get set }
    /// Percent of answered questions
    var percent: Float { get set }

    /// Update data with new questions
    func update()
    /// Setup defaults values
    func setup(category categoryKey: String, score: Set<Int>)
    /// Update current questions
    func nextQuestion()
    /// Check is right answer and add id of question
    func isRightAnswer(textAnswer: String) -> Bool
}

final class QuestionService: QuestionServiceInput {
    
    // MARK: - Properties
    
    var questions: [Question] = []
    var currentQuestion: Question? = nil
    
    var rightAnswerIds = Set<Int>()
    
    var countOfQuestions = 0
    var countOfQuestionsAnswered = ""
    var countOfRightAnsweredAndPercent = ""
    var countOfRightAnswersPerGame = 0
    var progress: Float = 0
    var isAnswered = false
    var percent: Float = 0
    
    //MARK: - Public methods
    
    func update() {
        isAnswered = false
        percent = Float(countOfRightAnswersPerGame)/Float(countOfQuestions)
        countOfQuestionsAnswered = "\(countOfQuestions-questions.count)/\(countOfQuestions)"
        countOfRightAnsweredAndPercent = "\(countOfRightAnswersPerGame) | \(String(format:"%.1f", percent*100))%"
        progress = Float(countOfQuestions - questions.count) / Float(countOfQuestions)
    }
    
    func setup(category categoryKey: String, score: Set<Int>) {
        questions = JSONLoader().loadData(filename: categoryKey).0
        for index in 0...questions.count - 1 {
            questions[index].answers.shuffle()
        }
        countOfQuestions = questions.count
        update()
        countOfRightAnswersPerGame = 0
        rightAnswerIds = score
        nextQuestion()
    }
    
    func nextQuestion() {
        currentQuestion = questions.first
        questions.remove(at: 0)
    }
    
    func isRightAnswer(textAnswer: String) -> Bool {
        let id = rightAnswerIds.first{$0 == currentQuestion?.id ?? -1}
        let answer = currentQuestion?.answers.first{$0.textAnswer == textAnswer && $0.correctAnswer == true}
        
        if id != nil && answer == nil {
            rightAnswerIds.remove(id ?? -1)
        }
        if id == nil && answer != nil && !isAnswered{
            rightAnswerIds.insert(currentQuestion?.id ?? -1)
        }
        
        countOfRightAnswersPerGame += (answer != nil) && !isAnswered ? 1 : 0
        
        return answer != nil 
    }
}

