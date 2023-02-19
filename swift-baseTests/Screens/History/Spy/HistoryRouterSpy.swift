
import Foundation
@testable import swift_base

class HistoryRouterSpy: HistoryRouterInput {

    // MARK: - Method call expectations

    private(set) var isShowActionsModuleCalled = false

    // MARK: - Spied methods

    func showActionsModule(output: swift_base.ActionsWithTrashButtonModuleOutput) {
        isShowActionsModuleCalled = true
    }
}
