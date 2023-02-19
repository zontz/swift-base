
import UIKit
import AVKit

enum Sound: String {
    case click
    case correctAnswer
    case incorrectAnswer
}

protocol SoundManagerInput {
    var player: AVAudioPlayer? { get set}
    func playSound(sound: Sound)
}

final class SoundManager: SoundManagerInput {
    
    static let shared = SoundManager()

    var player: AVAudioPlayer?

    func playSound(sound: Sound) {
        let isMuted = Archiver().loadFromUserDefaults(type: Int.self, forKey: SettingKey.sound.rawValue) == 1
        if isMuted { return }
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

