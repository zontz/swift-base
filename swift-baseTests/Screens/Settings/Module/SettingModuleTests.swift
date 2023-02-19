
import XCTest
@testable import swift_base

class SettingModuleTests: XCTestCase {

    // MARK: - Subject under test

    private var presenter: SettingPresenter!
    private let view = SettingViewControllerSpy()
    private let router = SettingRouterSpy()

    override func setUp() {
        super.setUp()
        presenter = SettingPresenter(router: router, archiver: Archiver())
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testViewWillAppearCallsPresenter() {
        // When
        presenter.viewWillAppear()

        // Then
        XCTAssert(view.isUpdateSettingViewCalled)
    }

    func testCloseButtonCallsPresenter() {
        // When
        presenter.closeButtonDidTap(settings: [:])

        // Then
        XCTAssert(view.isUpdateThemeCalled)
        XCTAssert(router.isDismissViewCalled)
    }
}


