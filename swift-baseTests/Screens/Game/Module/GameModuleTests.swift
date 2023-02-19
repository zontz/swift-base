
import XCTest
@testable import swift_base

class GameModuleTests: XCTestCase {

    // MARK: - Subject under test

    private var presenter: GamePresenter!
    private let view = GameViewControllerSpy()
    private let router = GameRouterSpy()

    override func setUp() {
        super.setUp()
        presenter = GamePresenter(router: router,
                                  with: Category(),
                                  arciver: Archiver(),
                                  questionService: QuestionService())
        presenter.view = view
    }


    override func tearDown() {
        super.tearDown()
        presenter = nil
    }

    func testHintButtonCallsPresenter() {
        // When
        presenter.hintButtonDidTap()

        // Then
        XCTAssert(router.isShowPopUpViewCalled)
    }

    func testCloseButtonCallsPresenter() {
        // When
        presenter.closeButtonDidTap()

        // Then
        XCTAssert(router.isShowMenuModuleCalled)
    }


    func testViewDidLoadCallsPresenter() {
        // When
        presenter.viewDidLoad()

        // Then
        XCTAssert(view.isUpdateProgressViewCalled)
        XCTAssert(view.isUpdateQuestionCalled)
    }

    func testAnswerButtonCallsPresenter() {
        // Given
        let button = UIButton()
        button.titleLabel?.text = "123"

        // When
        presenter.answerButtonDidTap(with: button)

        // Then
        XCTAssert(view.isPlaySoundCalled)
    }
}
