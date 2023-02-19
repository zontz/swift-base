
protocol HistoryModuleOutput: AnyObject {}

protocol HistoryModuleInput: AnyObject {}

final class HistoryPresenter: HistoryModuleInput {

    // MARK: - Propertie
    
    weak var view: HistoryViewInput?
    var router: HistoryRouterInput?
    var output: HistoryModuleOutput?
    
    private let archiver: ArchiverInput
    private var games: [Game]

    // MARK: - Lifecycle

    init(router: HistoryRouterInput, archiver: ArchiverInput) {
        self.router = router
        self.archiver = archiver
        self.games = archiver.loadFromUserDefaults(type: [Game].self, forKey: Keys.game.rawValue) ?? []
    }
}

// MARK: - HistoryViewOutput

extension HistoryPresenter: HistoryViewOutput {
    func viewWillDisappear() {
        archiver.deleteFromUserDefaults(forKey: Keys.game.rawValue)
        archiver.saveFromUserDefaults(data: games, forkey: Keys.game.rawValue)
    }

    func viewWillAppear() {
        view?.reloadTable(with: games)
    }
}

// MARK: - HistoryTableAdapterOutput

extension HistoryPresenter: HistoryTableAdapterOutput {
    func gamesDidChange(with games: [Game]) {
        self.games = games
        view?.reloadTable(with: games)
    }
}

// MARK: - HistoryHeaderViewOutput

extension HistoryPresenter: HistoryHeaderViewOutput {
    func trashButtonDidTap() {
        router?.showActionsModule(output: self)
    }
}

// MARK: - ActionsWithTrashButtonModuleOutput

extension HistoryPresenter: ActionsWithTrashButtonModuleOutput {
    func removeAll() {
        games.removeAll()
        view?.reloadTable(with: games)
    }
}




