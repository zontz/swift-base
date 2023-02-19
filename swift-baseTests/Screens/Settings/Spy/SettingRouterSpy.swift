
import Foundation
@testable import swift_base

class SettingRouterSpy: SettingRouterInput {

    // MARK: - Method call expectations

    private(set) var isDismissViewCalled = false

    // MARK: - Spied methods

    func dismissView() {
        isDismissViewCalled = true
    }
}
