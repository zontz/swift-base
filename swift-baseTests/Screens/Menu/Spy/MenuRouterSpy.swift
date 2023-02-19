
import Foundation
@testable import swift_base

class MenuRouterSpy: MenuRouterInput {

    // MARK: - Method call expectations

    private(set) var isShowCategoryModuleCalled = false
    private(set) var isShowHistoryModuleCalled = false
    private(set) var isShowGameModuleCalled = false
    private(set) var isShowSettingCalled = false
    private(set) var isShowProfileModuleCalled = false
    private(set) var isShowLeaderBoardModuleCalled = false

    // MARK: - Spied methods

    func showCategoryModule(output: swift_base.CategoryModuleOutput?) {
        isShowCategoryModuleCalled = true
    }

    func showHistoryModule() {
        isShowHistoryModuleCalled = true
    }

    func showGameModule(output: swift_base.GameModuleOutput?,
                        with category: swift_base.Category) {
        isShowGameModuleCalled = true
    }

    func showSetting() {
        isShowSettingCalled = true
    }

    func showFeatureFlagMenu() {

    }

    func showProfileModule(isEnabled: Bool) {
        isShowProfileModuleCalled = true
    }

    func showLeaderBoardModule(isEnabled: Bool) {
        isShowLeaderBoardModuleCalled = true
    }
}
