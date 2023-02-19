
import UIKit

protocol MenuRouterInput {
    func showCategoryModule(output: CategoryModuleOutput?)
    func showHistoryModule()
    func showGameModule(output: GameModuleOutput?, with category: Category)
    func showSetting()
    func showFeatureFlagMenu()
    func showProfileModule(isEnabled: Bool)
    func showLeaderBoardModule(isEnabled: Bool)
}


final class MenuRouter {

    // MARK: - Properties

    weak var view: ModuleTransitionable?
}

// MARK: - MenuRouterInput

extension MenuRouter: MenuRouterInput {
    func showProfileModule(isEnabled: Bool) {
        let tempVC = ScreenInDevelopmentViewController()
        tempVC.configure(isEnabled: isEnabled)
        view?.presentScreen(tempVC, animated: true, completion: nil)
    }

    func showLeaderBoardModule(isEnabled: Bool) {
        let tempVC = ScreenInDevelopmentViewController()
        tempVC.configure(isEnabled: isEnabled)
        view?.presentScreen(tempVC, animated: true, completion: nil)
    }

    func showSetting() {
        let settingsViewController = SettingsModuleConfigurator().configure()
        view?.presentScreen(settingsViewController, animated: true, completion: nil)
    }

    func showCategoryModule(output: CategoryModuleOutput?) {
        let categoryViewController = CategoryModuleConfigurator().configure(output: output)
        view?.presentScreen(categoryViewController,
                             animated: true,
                             completion: nil)
    }

    func showHistoryModule() {
        let historyViewController = HistoryModuleConfigurator().configure()
        view?.presentScreen(historyViewController,
                             animated: true,
                             completion: nil)
    }

    func showGameModule(output: GameModuleOutput?, with category: Category) {
        let gameViewController = GameModuleConfigurator().configure(output: output,
                                                                      with: category)
        view?.presentScreen(gameViewController,
                             animated: true,
                             completion: nil)
    }
    func showFeatureFlagMenu() {
        let featureFlagMenuViewController = FeatureFlagMenuViewController()
        view?.presentScreen(featureFlagMenuViewController, animated: true, completion: nil)
    }
}


