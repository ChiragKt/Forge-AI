import Foundation
import AVFoundation
import SwiftUI

enum SoundOption: String {
    case click = "clicksound"
    case premium = "premium"
}

class SoundManager {
   

    static let instance = SoundManager()
    @AppStorage("isSoundOn") var isSoundOn = true
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "wav") else {
            print("Sound file not found for \(sound.rawValue).")
            return
        }
        
        do {
            if isSoundOn{
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            }
        } catch let error {
            print("Error playing sound: \(error.localizedDescription).")
        }
    }
}


