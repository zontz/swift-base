
import XCTest
@testable import swift_base

final class SettingsModuleConfiguratorTests: XCTestCase {

    // MARK: - Properties

    // System under test
    private var viewController: SettingsViewController!

    // MARK: - Life Cycle

    override func setUp() {
        super.setUp()
        viewController = SettingsModuleConfigurator().configure()
    }

    override func tearDown() {
        super.tearDown()
        viewController = nil
    }

    // MARK: - Tests

    func testViewOutput() {
        // Given
        let isPresenter = viewController.output is SettingPresenter
        // Then
        XCTAssertTrue(isPresenter, "viewController.output is not SettingPresenter")
    }

    func testViewInput() {
        // Given
        guard let presenter = viewController.output as? SettingPresenter else {
            XCTFail("Cannot assign viewController.output as SettingPresenter")
            return
        }

        let isViewController = presenter.view is SettingsViewController
        // Then
        XCTAssertTrue(isViewController, "presenter.view is not SettingsViewController")
    }

    func testRouterInput() {
        // Given
        guard let presenter = viewController.output as? SettingPresenter else {
            XCTFail("Cannot assign viewController.output as SettingPresenter")
            return
        }

        let isRouter = presenter.router is SettingsRouter
        // Then
        XCTAssertTrue(isRouter, "presenter.router is not SettingsRouter")
    }

    func testScreenTransitionable() {
        // Given
        guard let presenter = viewController.output as? SettingPresenter else {
            XCTFail("Cannot assign viewController.output as SettingPresenter")
            return
        }
        guard let router = presenter.router as? SettingsRouter else {
            XCTFail("Cannot assign presenter.router as SettingsRouter")
            return
        }

        let isViewController = router.view is SettingsViewController
        // Then
        XCTAssertTrue(isViewController, "router.view is not SettingsViewController")
    }
}

