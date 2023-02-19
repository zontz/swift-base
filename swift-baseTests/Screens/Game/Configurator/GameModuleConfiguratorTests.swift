
import XCTest
@testable import swift_base

final class GameModuleConfiguratorTests: XCTestCase {

    // MARK: - Properties

    // System under test
    private var viewController: GameViewController!

    // MARK: - Life Cycle

    override func setUp() {
        super.setUp()
        viewController = GameModuleConfigurator().configure()
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

    // MARK: - Tests

    func testViewOutput() {
        // Given
        let isPresenter = viewController.output is GamePresenter
        // Then
        XCTAssertTrue(isPresenter, "viewController.output is not GamePresenter")
    }

    func testViewInput() {
        // Given
        guard let presenter = viewController.output as? GamePresenter else {
            XCTFail("Cannot assign viewController.output as GamePresenter")
            return
        }

        let isViewController = presenter.view is GameViewController
        // Then
        XCTAssertTrue(isViewController, "presenter.view is not GameViewController")
    }

    func testRouterInput() {
        // Given
        guard let presenter = viewController.output as? GamePresenter else {
            XCTFail("Cannot assign viewController.output as GamePresenter")
            return
        }
        let isRouter = presenter.router is GameRouter
        // Then
        XCTAssertTrue(isRouter, "presenter.router is not GameRouter")
    }

    func testScreenTransitionable() {
        // Given
        guard let presenter = viewController.output as? GamePresenter else {
            XCTFail("Cannot assign viewController.output as GamePresenter")
            return
        }
        guard let router = presenter.router as? GameRouter else {
            XCTFail("Cannot assign presenter.router as GameRouter")
            return
        }

        let isViewController = router.view is GameViewController
        // Then
        XCTAssertTrue(isViewController, "router.view is not GameViewController")
    }
}

