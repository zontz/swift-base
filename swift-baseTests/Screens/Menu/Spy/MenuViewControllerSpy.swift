
import Foundation
@testable import swift_base

class MenuViewControllerSpy: MenuViewInput {

    // MARK: - Method call expectations

    private(set) var isUpdateCategoryViewCalled = false
    private(set) var isUpdateCountAndScoreCalled = false
    private(set) var isUpdateGameCalled = false

    // MARK: - Spied methods

    func updateCategoryView(with category: swift_base.Category) {
        isUpdateCategoryViewCalled = true
    }


    func updateCountAndScore(with count: Int, and score: Int) {
        isUpdateCountAndScoreCalled = true
    }


    func updateGame(with game: swift_base.Game) {
        isUpdateGameCalled = true
    }
}
