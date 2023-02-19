
import Foundation

// MARK: - Game

struct Game: Codable {

    var storeData: Data? {
        return try? JSONEncoder().encode(self)
    }

    let date: String
    var category: String
    var countOfQuestionsAnswered: String
    var countOfQuestions: Int
    var score: Int
    var percent: Float
    init(date: String = "",
         category: String = "",
         countOfQuestionsAnswered: String = "",
         countOfQuestions: Int = 0,
         score: Int = 0,
         percent: Float = 0) {
        self.date = date
        self.category = category
        self.countOfQuestionsAnswered = countOfQuestionsAnswered
        self.countOfQuestions = countOfQuestions
        self.score = score
        self.percent = percent
    }
}
