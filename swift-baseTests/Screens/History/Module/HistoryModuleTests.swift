
import XCTest
@testable import swift_base

class HistoryModuleTests: XCTestCase {

    // MARK: - Subject under test

    private var presenter: HistoryPresenter!
    private let view = HistoryViewControllerSpy()
    private let router = HistoryRouterSpy()

    override func setUp() {
        super.setUp()
        presenter = HistoryPresenter(router: router, archiver: Archiver())
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testRemoveAllCallsPresenter() {
        // When
        presenter.removeAll()

        // Then
        XCTAssert(view.isReloadTableCalled)
    }

    func testTrashButtonCallsPresenter() {
        // When
        presenter.trashButtonDidTap()

        // Then
        XCTAssert(router.isShowActionsModuleCalled)
    }
}
