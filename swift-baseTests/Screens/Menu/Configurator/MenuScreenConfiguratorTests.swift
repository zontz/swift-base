
import XCTest
@testable import swift_base

final class MenuModuleConfiguratorTests: XCTestCase {

    // MARK: - Subject under test

    private var viewController: MenuViewController!


    override func setUp() {
        super.setUp()
        viewController = MenuModuleConfigurator().configure()
    }

    // MARK: - Tests

    func testViewOutput() {
        // Given
        let isPresenter = viewController.output is MenuPresenter
        // Then
        XCTAssertTrue(isPresenter, "viewController.output is not MenuPresenter")
    }

    func testViewInput() {
        // Given
        guard let presenter = viewController.output as? MenuPresenter else {
            XCTFail("Cannot assign viewController.output as MenuPresnter")
            return
        }

        let isViewController = presenter.view is MenuViewController
        // Then
        XCTAssertTrue(isViewController, "presenter.view is not MenuViewController")
    }

    func testRouterInput() {
        // Given
        guard let presenter = viewController.output as? MenuPresenter else {
            XCTFail("Cannot assign viewController.output as MenuPresnter")
            return
        }

        let isRouter = presenter.router is MenuRouter
        // Then
        XCTAssertTrue(isRouter, "presenter.router is not MenuRouter")
    }

    func testScreenTransitionable() {
        // Given
        guard let presenter = viewController.output as? MenuPresenter else {
            XCTFail("Cannot assign viewController.output as MenuPresnter")
            return
        }
        guard let router = presenter.router as? MenuRouter else {
            XCTFail("Cannot assign presenter.router as MenuRouter")
            return
        }

        let isViewController = router.view is MenuViewController
        // Then
        XCTAssertTrue(isViewController, "router.view is not MenuViewController")
    }
}

