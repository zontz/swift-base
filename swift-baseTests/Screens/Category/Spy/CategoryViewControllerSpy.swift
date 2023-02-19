
import Foundation
@testable import swift_base

class CategoryViewControllerSpy: CategoryViewInput {

    // MARK: - Method call expectations

    private(set) var isUpdateHeaderViewCalled = false
    private(set) var isRealoadTableCalled = false

    // MARK: - Spied methods

    func updateHeaderView(with game: swift_base.Game) {
        isUpdateHeaderViewCalled = true
    }

    func realoadTable() {
        isRealoadTableCalled = true
    }
}
