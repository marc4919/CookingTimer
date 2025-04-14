//
//  ContentView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 8/4/25.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    @State private var minutes = 0
    @State private var seconds = 0
    private var totalSeconds: Int {
        (minutes * 60) + seconds
    }
    @State private var isTimerRunning = false
    @State private var player: AVAudioPlayer?
    @State private var selectedSound: String = "start"
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }

    var body: some View {
        #if DEBUG
            let _ = Self._printChanges()
        #endif
        VStack {
            
            VStack(spacing: 50) {
                if isTimerRunning {
                    Text("\(minutes) m \(seconds) s")
                        .font(.largeTitle)
                        .padding().frame(width: 400, height: 160)
                } else {
                    
                    HStack {
                        Picker("minutes", selection: $minutes) {
                            ForEach(0...59, id: \.self) { index in
                                Text("\(index)")
                                    .tag(index)
                                    .font(.title)
                                    .foregroundStyle(.black)
                            }
                        }.pickerStyle(.wheel).frame(width: 160, height: 160)
                            .disabled(isTimerRunning)
                        Picker("seconds", selection: $seconds) {
                            ForEach(0...59, id: \.self) { index in
                                Text("\(index)")
                                    .tag(index)
                                    .font(.title)
                                    .foregroundStyle(.black)
                            }
                        }.pickerStyle(.wheel).frame(width: 160, height: 160)
                            .disabled(isTimerRunning)
                    }
                }
                
                Button(role: isTimerRunning ? .cancel : nil) {
                    isTimerRunning ? stopTimer() : startTimer()
                } label: {
                    Label(
                        isTimerRunning ? "Stop timer" : "Start timer",
                        systemImage: isTimerRunning ? "xmark.circle" : "timer"
                    )
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
                    .background(isTimerRunning ? .red : .blue, in: Capsule())
                }
                
            }.padding().frame(maxWidth: 380, maxHeight: isLandscape ? 350 : 500).background(.white).cornerRadius(20)
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.orange)
        

    }

    private func startTimer() {
        Task {
            if seconds > 0 || minutes > 0 {
                isTimerRunning = true
                selectedSound = "start"
                playSound()
            }
            try? await Task.sleep(for: .seconds(0.8))
            while totalSeconds > 0 && isTimerRunning {
                if seconds == 0 && minutes > 0 {
                    minutes -= 1
                    seconds = 59
                    print("uno")
                    try? await Task.sleep(for: .seconds(1))
                } else if totalSeconds == 1 {
                    seconds -= 1
                    isTimerRunning = false
                    stopTimer()
                    selectedSound = "finish"
                    playSound()
                } else {
                    print("tres")
                    seconds -= 1
                    try? await Task.sleep(for: .seconds(1))
                }
            }
        }
    }

    private func stopTimer() {
            isTimerRunning = false
        if totalSeconds > 0 {
            selectedSound = "stop"
            playSound()
        }
    }

    private func playSound() {
        guard
            let soundURL = Bundle.main.url(
                forResource: selectedSound,
                withExtension: "wav"
            )
        else {
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
        } catch {
            print("Failed to load the sound: \(error)")
        }
        player?.play()
    }
}

#Preview {
    ContentView()
}
