
import XCTest
@testable import swift_base

final class HistoryModuleConfiguratorTests: XCTestCase {

    // MARK: - Properties

    // System under test
    private var viewController: HistoryViewController!

    // MARK: - Life Cycle

    override func setUp() {
        super.setUp()
        viewController = HistoryModuleConfigurator().configure()
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

    // MARK: - Tests

    func testViewOutput() {
        // Given
        let isPresenter = viewController.output is HistoryPresenter
        // Then
        XCTAssertTrue(isPresenter, "viewController.output is not HistoryPresenter")
    }

    func testViewInput() {
        // Given
        guard let presenter = viewController.output as? HistoryPresenter else {
            XCTFail("Cannot assign viewController.output as HistoryPresenter")
            return
        }
        let isViewController = presenter.view is HistoryViewController
        // Then
        XCTAssertTrue(isViewController, "presenter.view is not HistoryViewController")
    }

    func testRouterInput() {
        // Given
        guard let presenter = viewController.output as? HistoryPresenter else {
            XCTFail("Cannot assign viewController.output as HistoryPresenter")
            return
        }
        let isRouter = presenter.router is HistoryRouter
        // Then
        XCTAssertTrue(isRouter, "presenter.router is not HistoryRouter")
    }

    func testScreenTransitionable() {
        // Given
        guard let presenter = viewController.output as? HistoryPresenter else {
            XCTFail("Cannot assign viewController.output as HistoryPresenter")
            return
        }
        guard let router = presenter.router as? HistoryRouter else {
            XCTFail("Cannot assign presenter.router as HistoryRouter")
            return
        }

        let isViewController = router.view is HistoryViewController
        // Then
        XCTAssertTrue(isViewController, "router.view is not HistoryViewController")
    }
}

