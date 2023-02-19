
import UIKit

final class SettingsModuleConfigurator {
    func configure(output: SettingModuleOutput? = nil) -> SettingsViewController {

        let settingView = SettingView()
        let archiver = Archiver()

        let router = SettingsRouter()
        let presenter = SettingPresenter(router: router, archiver: archiver)
        let view = SettingsViewController(output: presenter, settingView: settingView)

        presenter.view = view
        presenter.output = output
        settingView.output = presenter
        router.view = view

        return view
    }
}
