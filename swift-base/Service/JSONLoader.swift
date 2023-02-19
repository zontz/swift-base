import UIKit

protocol JSONLoaderInput {
    /// load Questions and category from file
    func loadData(filename fileName: String) -> ([Question],Category)
    /// load all categorys from files
    func loadCategorys(filenames fileNames: [String]) -> [Category]
    /// load countOfQuestions
    func loadCountOfQuestions() -> Int
}

final class JSONLoader: JSONLoaderInput {
    func loadData(filename fileName: String) -> ([Question],Category) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            do {
                let data = try Data(contentsOf: url)
                let jsonData = try JSONDecoder().decode(QuestionResponse.self, from: data)
                return (jsonData.question ?? [], jsonData.category)
            } catch {
                print("error:\(error)")
            }
        }
        return ([],Category())
    }

    func loadCategorys(filenames fileNames: [String]) -> [Category] {
        var categorys: [Category] = []
        for fileName in fileNames {
            categorys.append(loadData(filename: fileName).1)
        }
        return categorys
    }

    func loadCountOfQuestions() -> Int {
        var count = 0

        for file in Resources.fileNames {
            count += loadData(filename: file).0.count
        }
        return count
    }
}
