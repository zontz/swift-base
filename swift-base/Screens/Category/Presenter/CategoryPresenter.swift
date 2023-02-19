
protocol CategoryModuleOutput: AnyObject {
    /// Notify that category did change
    func categoryDidChange(with category: Category)
}

protocol CategoryModuleInput: AnyObject {}

final class CategoryPresenter: CategoryViewOutput, CategoryModuleInput {

    // MARK: - Properties

    weak var view: CategoryViewInput?
    var router: CategoryRouterInput?
    var output: CategoryModuleOutput?

    private let archiver: ArchiverInput

    // MARK: - Lifecycle
    
    init(router: CategoryRouterInput, archiver: ArchiverInput) {
        self.router = router
        self.archiver = archiver
    }
}

// MARK: - CategoryTableAdapterOutput

extension CategoryPresenter: CategoryTableAdapterOutput {
    func categoryButtonDidTap(with category: Category) {
        var game = archiver.loadFromUserDefaults(type: [Game].self, forKey: Keys.game.rawValue)?.first ?? Game()

        if game.category != category.name {
            game.category = category.name
            game.countOfQuestions = category.countOfQuestions
        }

        view?.updateHeaderView(with: game)
        view?.realoadTable()
        output?.categoryDidChange(with: category)
    }
}

