//
//  SoundVM.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 15/4/25.
//

import AVFoundation

import AVFoundation

final class SoundVM {
    private var player: AVAudioPlayer?

    init(preload sound: String) {
        prepareSound(named: sound)
        player?.prepareToPlay()
    }

    func playSound(selectedSound: String) {
        prepareSound(named: selectedSound)
        player?.play()
    }

    private func prepareSound(named sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "wav") else {
            print("Sound file '\(sound)' not found")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Failed to load the sound '\(sound)': \(error)")
        }
    }
}
