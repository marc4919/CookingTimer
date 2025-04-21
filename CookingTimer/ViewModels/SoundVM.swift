//
//  SoundVM.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 15/4/25.
//

import AVFoundation


/// A sound manager that handles loading and playing short audio clips using `AVAudioPlayer`.
///
/// This class provides a simple interface to play sound effects stored in the app bundle.
/// All audio files are expected to be in `.wav` format.
final class SoundVM {
    
    /// The audio player instance used to play sounds.
    private var player: AVAudioPlayer?
    
    /// Plays the selected sound. Prepares the audio first and then starts playback.
    /// - Parameter selectedSound: The name of the sound file to be played (without extension).
    func playSound(selectedSound: String) {
        prepareSound(named: selectedSound)
        player?.play()
    }
    
    /// Prepares the audio to be played by loading and pre-buffering it.
    /// Each time a sound is selected, this method loads and prepares it using `prepareToPlay()`.
    /// - Parameter sound: The name of the sound file to load (without extension).
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
