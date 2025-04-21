//
//  TimerVM.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 17/4/25.
//

import AVFoundation

/// A view model that manages a countdown timer and sound feedback for its state transitions.
///
/// The timer can be started and stopped manually. It automatically plays different sounds when starting,
/// stopping or finishing, depending on whether sound is enabled. The timer state (`isTimerRunning`)
/// and remaining time (`minutes`, `seconds`) are exposed as observable properties.
@MainActor
@Observable
final class TimerVM {
    /// The number of minutes remaining in the timer.
    var minutes: Int = 0
    
    /// The number of seconds remaining in the timer.
    var seconds: Int = 0
    
    /// Indicates whether the timer is currently running.
    var isTimerRunning: Bool = false
    
    /// Indicates whether sound feedback is enabled.
    /// Returns `true` by default if no preference is stored in `UserDefaults`.
    var isSoundEnabled: Bool {
        if UserDefaults.standard.object(forKey: "is_sound_enabled") == nil {
            return true
        } else {
            return UserDefaults.standard.bool(forKey: "is_sound_enabled")
        }
    }

    /// The total number of seconds remaining, combining minutes and seconds.
    var totalSeconds: Int {
        minutes * 60 + seconds
    }
    
    /// The sound manager instance used to play sounds.
    private var soundVM = SoundVM()
    
    /// Starts the countdown timer asynchronously.
    ///
    /// If the initial time is greater than zero and sound is enabled, it plays the "start" sound.
    /// The timer waits briefly, then begins counting down every second.
    ///
    /// - If seconds reach 0 and there are still minutes remaining, it subtracts 1 minute and resets seconds to 59.
    /// - When only 1 second remains, it stops the timer calling ``stopTimer()`` and plays the "finish" sound (if enabled) with ``SoundVM/playSound(selectedSound:)``.
    /// - Otherwise, it simply subtracts one second per iteration.
    func startTimer() {
        Task {
            if seconds > 0 || minutes > 0 {
                isTimerRunning = true
                if isSoundEnabled != false {
                    soundVM.playSound(selectedSound: "start")
                }
            }
            try? await Task.sleep(for: .seconds(0.8))
            while totalSeconds > 0 && isTimerRunning {
                if seconds == 0 && minutes > 0 {
                    minutes -= 1
                    seconds = 59
                    try? await Task.sleep(for: .seconds(1))
                } else if totalSeconds == 1 {
                    seconds -= 1
                    isTimerRunning = false
                    stopTimer()
                    if isSoundEnabled {
                        soundVM.playSound(selectedSound: "finish")
                    }
                } else {
                    seconds -= 1
                    try? await Task.sleep(for: .seconds(1))
                }
            }
        }
    }
    
    /// Stops the running timer.
    /// If there is remaining time and sound is enabled, it plays the stop sound with ``SoundVM/playSound(selectedSound:)``.
    func stopTimer() {
        isTimerRunning = false
        if totalSeconds > 0 && isSoundEnabled {
            soundVM.playSound(selectedSound: "stop")
        }
    }
}
