
import UIKit

protocol MenuModuleOutput: AnyObject {}

protocol MenuModuleInput: AnyObject {}

final class MenuPresenter {

    // MARK: - Properties

    weak var view: MenuViewInput?
    var router: MenuRouterInput?
    var output: MenuModuleOutput?

    private let jsonLoader: JSONLoaderInput
    private let archiver: ArchiverInput
    private var category: Category

    // MARK: - Life Cycle

    init(router: MenuRouterInput,
         jsonLoader: JSONLoaderInput,
         archiver: ArchiverInput) {
        self.router = router
        self.jsonLoader = jsonLoader
        self.archiver = archiver
        self.category = Category(name: "Логические операторы",
                                 key: "Operations")
    }
}

// MARK: - MenuViewOutput

extension MenuPresenter: MenuViewOutput {
    func profileButtonDidTap() {
        let index = Resources.FlagName.profile.rawValue
        router?.showProfileModule(isEnabled: UserDefaults.standard.bool(forKey: Resources.flags[index].featureFlagName))
    }

    func leaderBoardButtonDidTap() {
        let index = Resources.FlagName.leaderboard.rawValue
        router?.showLeaderBoardModule(isEnabled: UserDefaults.standard.bool(forKey: Resources.flags[index].featureFlagName))
    }

    func featureButtonDidTap() {
        router?.showFeatureFlagMenu()
    }

    func settingsButtonDidTap() {
        router?.showSetting()
    }
    
    func viewWillAppear() {
        let count = archiver.loadFromUserDefaults(type: Set<Int>.self, forKey: Keys.score.rawValue)?.count ?? 0
        let game = archiver.loadFromUserDefaults(type: [Game].self, forKey: Keys.game.rawValue)?.first ?? Game()

        view?.updateCountAndScore(with: jsonLoader.loadCountOfQuestions(),
                                   and: count)
        view?.updateGame(with: game)
    }

    func historyButtonDidTap() {
        router?.showHistoryModule()
    }

    func gameButtonDidTap() {
        router?.showGameModule(output: self, with: category)
    }
}

// MARK: - CategoryModuleOutput

extension MenuPresenter: CategoryModuleOutput {
    func categoryDidChange(with category: Category) {
        self.category = category
        view?.updateCategoryView(with: category)
    }
}

// MARK: - GameModuleOutput

extension MenuPresenter: GameModuleOutput {
    func gameIsEnd(with game: Game) {
        view?.updateGame(with: game)
        viewWillAppear()
    }
}

// MARK: - CurrentCategoryViewOutput

extension MenuPresenter: CurrentCategoryViewOutput {
    func categoryButtonDidTap() {
        router?.showCategoryModule(output: self)
    }
}
