

import XCTest
@testable import swift_base

final class CategoryModuleConfiguratorTests: XCTestCase {

    // MARK: - Properties

    // System under test
    private var viewController: CategoryViewController!

    // MARK: - Life Cycle

    override func setUp() {
        super.setUp()
        viewController = CategoryModuleConfigurator().configure()
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

    // MARK: - Tests

    func testViewOutput() {
        // Given
        let isPresenter = viewController.output is CategoryPresenter
        // Then
        XCTAssertTrue(isPresenter, "viewController.output is not CategoryPresenter")
    }

    func testViewInput() {
        // Given
        guard let presenter = viewController.output as? CategoryPresenter else {
            XCTFail("Cannot assign viewController.output as CategoryPresenter")
            return
        }

        let isViewController = presenter.view is CategoryViewController
        // Then
        XCTAssertTrue(isViewController, "presenter.view is not CategoryViewController")
    }

    func testRouterInput() {
        // Given
        guard let presenter = viewController.output as? CategoryPresenter else {
            XCTFail("Cannot assign viewController.output as CategoryPresenter")
            return
        }

        let isRouter = presenter.router is CategoryRouter
        // Then
        XCTAssertTrue(isRouter, "presenter.router is not CategoryRouter")
    }

    func testScreenTransitionable() {
        // Given
        guard let presenter = viewController.output as? CategoryPresenter else {
            XCTFail("Cannot assign viewController.output as CategoryPresenter")
            return
        }
        guard let router = presenter.router as? CategoryRouter else {
            XCTFail("Cannot assign presenter.router as CategoryRouter")
            return
        }

        let isViewController = router.view is CategoryViewController
        // Then
        XCTAssertTrue(isViewController, "router.view is not CategoryViewController")
    }
}
