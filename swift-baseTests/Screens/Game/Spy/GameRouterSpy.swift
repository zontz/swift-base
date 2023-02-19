
import Foundation
@testable import swift_base

class GameRouterSpy: GameRouterInput {

    // MARK: - Method call expectations

    private(set) var isShowMenuModuleCalled = false
    private(set) var isShowPopUpViewCalled = false


    // MARK: - Spied methods

    func showMenuModule() {
        isShowMenuModuleCalled = true
    }

    func showPopUpView(output: swift_base.PopUpViewOutput?,
                       mainText: String,
                       secondText: String,
                       closeButtonText: String) {
        isShowPopUpViewCalled = true
    }
}
