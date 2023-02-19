
protocol SettingModuleOutput: AnyObject {}

protocol SettingModuleInput: AnyObject {}

final class SettingPresenter {

    // MARK: - Properties

    weak var view: SettingsViewInput?
    var router: SettingRouterInput?
    var output: SettingModuleOutput?

    private let archiver: ArchiverInput

    // MARK: - Life Cycle

    init(router: SettingRouterInput, archiver: ArchiverInput) {
        self.router = router
        self.archiver = archiver
    }
}

// MARK: - SettingViewOutput

extension SettingPresenter: SettingViewOutput {
    func closeButtonDidTap(settings: Dictionary<SettingKey, Int>) {
        settings.forEach {
            archiver.saveFromUserDefaults(data: $0.value, forkey: $0.key.rawValue)
        }
        view?.updateTheme(theme: settings[.theme] ?? 0)
        router?.dismissView()
    }
}

// MARK: - SettingsViewOutput

extension SettingPresenter: SettingsViewOutput {
    func viewWillAppear() {
        var settings: Dictionary<SettingKey,Int> = [:]
        SettingKey.allCases.forEach {
            settings[$0] = archiver.loadFromUserDefaults(type: Int.self,
                                                         forKey: $0.rawValue)
        }
        view?.updateSettingView(settings: settings)
    }
}
