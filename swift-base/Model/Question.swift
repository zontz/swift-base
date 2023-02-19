
import Foundation

// MARK: - QuestionResponse

struct QuestionResponse: Codable {
    let category: Category
    let question: [Question]?
}

// MARK: - Category

struct Category: Codable {
    let name, key: String
    let countOfQuestions : Int
    let isEnable: Bool
    init(name: String = "",
         key: String = "",
         countOfQuestions: Int = 0,
         isEnable: Bool = false) {
        self.name = name
        self.key = key
        self.countOfQuestions = countOfQuestions
        self.isEnable = isEnable
    }
}

// MARK: - Question

struct Question: Codable {
    let id: Int
    let textQuestion: String
    var answers: [Answer]
    let hint: String
}

// MARK: - Answer

struct Answer: Codable {
    let textAnswer: String
    let correctAnswer: Bool?
}

