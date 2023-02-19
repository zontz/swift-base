
import XCTest
@testable import swift_base

class MenuModuleTests: XCTestCase {

    // MARK: - Subject under test

    private var presenter: MenuPresenter!
    private let view = MenuViewControllerSpy()
    private let router = MenuRouterSpy()

    // MARK: - Test lifecycle

    override func setUp() {
        super.setUp()
        presenter = MenuPresenter(router: router,
                                  jsonLoader: JSONLoader(),
                                  archiver: Archiver())
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testviewWillAppearCallsPresenter() {
        // When
        presenter.viewWillAppear()
        
        // Then
        XCTAssert(view.isUpdateCountAndScoreCalled)
        XCTAssert(view.isUpdateGameCalled)
    }

    func testCategoryDidChangeCallsPresenter() {
        // When
        presenter.categoryDidChange(with: Category())

        // Then
        XCTAssert(view.isUpdateCategoryViewCalled)
    }

    func testHistoryButtonCallsPresenter() {
        // When
        presenter.historyButtonDidTap()

        // Then
        XCTAssert(router.isShowHistoryModuleCalled)
    }

    func testGameButtonCallsPresenter() {
        // When
        presenter.gameButtonDidTap()

        // Then
        XCTAssert(router.isShowGameModuleCalled)
    }

    func testSettingButtonCallsPresenter() {
        // When
        presenter.settingsButtonDidTap()

        // Then
        XCTAssert(router.isShowSettingCalled)
    }

    func testProfileButtonCallsPresenter() {
        // When
        presenter.profileButtonDidTap()

        // Then
        XCTAssert(router.isShowProfileModuleCalled)
    }

    func testLeaderBoardButtonCallsPresenter() {
        // When
        presenter.leaderBoardButtonDidTap()

        // Then
        XCTAssert(router.isShowLeaderBoardModuleCalled)
    }

    func testCategoryButtonCallsPresenter() {
        // When
        presenter.categoryButtonDidTap()

        // Then
        XCTAssert(router.isShowCategoryModuleCalled)
    }
}
