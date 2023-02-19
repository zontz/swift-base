
import UIKit

protocol SettingRouterInput {
    func dismissView()
}

class SettingsRouter: SettingRouterInput {
    weak var view: ModuleTransitionable?

    func dismissView() {
        view?.dismissView(animated: true, completion: nil)
    }
}
