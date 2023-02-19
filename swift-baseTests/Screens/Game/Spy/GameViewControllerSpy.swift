
import Foundation
@testable import swift_base

class GameViewControllerSpy: GameViewInput {

    // MARK: - Method call expectations

    private(set) var isUpdateQuestionCalled = false
    private(set) var isUpdateProgressViewCalled = false
    private(set) var isPlaySoundCalled = false

    // MARK: - Spied methods

    func updateQuestion(_ question: swift_base.Question?) {
        isUpdateQuestionCalled = true
    }

    func updateProgressView(textRightAnswer: String,
                            textCountQuestion: String,
                            progress: Float) {
        isUpdateProgressViewCalled = true
    }

    func playSound(sound: swift_base.Sound) {
        isPlaySoundCalled = true
    }
}
