
import Foundation
@testable import swift_base

class HistoryViewControllerSpy: HistoryViewInput {

    // MARK: - Method call expectations

    private(set) var isReloadTableCalled = false

    // MARK: - Spied methods

    func reloadTable(with items: [swift_base.Game]) {
        isReloadTableCalled = true
    }
}
