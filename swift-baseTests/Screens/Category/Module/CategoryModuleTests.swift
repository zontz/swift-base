
import XCTest
@testable import swift_base


class CategoryModuleTests: XCTestCase {

    // MARK: - Subject under test

    private var presenter: CategoryPresenter!
    private let view = CategoryViewControllerSpy()

    override func setUp() {
        super.setUp()
        presenter = CategoryPresenter(router: CategoryRouter(), archiver: Archiver())
        presenter.view = view
    }

    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testCategoryButtonCallsPresenter() {
        // When
        presenter.categoryButtonDidTap(with: Category())

        // Then
        XCTAssert(view.isUpdateHeaderViewCalled)
        XCTAssert(view.isRealoadTableCalled)
    }
}

