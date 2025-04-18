//
//  SoundVM.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 15/4/25.
//

import AVFoundation

final class SoundVM {
    private var player: AVAudioPlayer?

    func playSound(selectedSound: String) {
        prepareSound(named: selectedSound)
        player?.play()
    }

    private func prepareSound(named sound: String) {
        guard
            let url = Bundle.main.url(forResource: sound, withExtension: "wav")
        else {
            print("Sound file '\(sound)' not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
        } catch {
            print("Failed to load the sound '\(sound)': \(error)")
        }
    }
}
