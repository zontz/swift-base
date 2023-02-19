
import Foundation
@testable import swift_base

class SettingViewControllerSpy: SettingsViewInput {

    // MARK: - Method call expectations

    private(set) var isUpdateSettingViewCalled = false
    private(set) var isUpdateThemeCalled = false

    // MARK: - Spied methods

    func updateSettingView(settings: Dictionary<swift_base.SettingKey, Int>) {
        isUpdateSettingViewCalled = true
    }

    func updateTheme(theme: Int) {
        isUpdateThemeCalled = true
    }
}
