//
//  TimerVM.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 17/4/25.
//

import AVFoundation

@MainActor
@Observable
final class TimerVM {
    var minutes: Int = 0
    var seconds: Int = 0
    var isTimerRunning: Bool = false

    private var soundVM = SoundVM()

    var totalSeconds: Int {
        minutes * 60 + seconds
    }

    func startTimer() {
        Task {
            if seconds > 0 || minutes > 0 {
                isTimerRunning = true
                soundVM.playSound(selectedSound: "start")
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
                    soundVM.playSound(selectedSound: "finish")
                } else {
                    seconds -= 1
                    try? await Task.sleep(for: .seconds(1))
                }
            }
        }
    }

    func stopTimer() {
        isTimerRunning = false
        if totalSeconds > 0 {
            soundVM.playSound(selectedSound: "stop")
        }
    }
}
