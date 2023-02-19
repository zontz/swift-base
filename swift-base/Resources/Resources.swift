
import UIKit

struct Resources {

    enum Colors {
        static let mainColor = UIColor(named: "MainColor")
        static let textColor = UIColor(named: "TextColor")
        static let backgroundColor = UIColor(named: "BackgroundColor")
    }

    enum FlagName: Int {
        case leaderboard
        case profile
    }
    
    static let fileNames = ["Operations",
                             "Methods",
                             "Set",
                             "Optionals",
                             "ClassAndStructure"]

    static let themes: [(key: String, arrays: [[String]])] = [
        ("Рандом", [["Methods","Set"],["Operations"]]),
        ("Swift", [["Optionals","ClassAndStructure"]])
    ]

    static var flags = [FeatureFlag(featureFlagName: "isLeaderBoardEnabled",
                                    featureFlagDescription: "Доступна ли страница рекордов, которая отображает топ 10 лучших игроков в этой категории",
                                    isFeatureFlagEnabled: false),

                         FeatureFlag(featureFlagName: "isProfileEnabled",
                                     featureFlagDescription: "Доступен ли экран с профилем игрока, где храниться его прогресс и уровень",
                                     isFeatureFlagEnabled: false)]
}
