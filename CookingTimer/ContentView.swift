//
//  ContentView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var minutes = 0
    @State private var seconds = 0
    private var totalSeconds: Int {
        (minutes * 60) + seconds
    }
    @State private var isTimerRunning = false
    @StateObject private var soundVM = SoundVM()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }

    var body: some View {
        #if DEBUG
            let _ = Self._printChanges()
        #endif
        NavigationStack {
            VStack {
                VStack(spacing: 50) {
                    if isTimerRunning {
                        Text("\(minutes) m \(seconds) s")
                            .font(.largeTitle)
                            .padding().frame(width: 400, height: 160)
                    } else {

                        HStack {
                            PickerView(
                                pickerSelection: $minutes,
                                isTimerRunning: isTimerRunning,
                                pickerLabel: "minutes"
                            )
                            PickerView(
                                pickerSelection: $seconds,
                                isTimerRunning: isTimerRunning,
                                pickerLabel: "seconds"
                            )
                        }

                    }

                    Button(role: isTimerRunning ? .cancel : nil) {
                        isTimerRunning ? stopTimer() : startTimer()
                    } label: {
                        Label(
                            isTimerRunning ? "Stop timer" : "Start timer",
                            systemImage: isTimerRunning
                                ? "xmark.circle" : "timer"
                        )
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            isTimerRunning ? .red : .blue,
                            in: Capsule()
                        )
                    }

                }.padding().frame(
                    maxWidth: 380,
                    maxHeight: isLandscape ? 350 : 500
                )
                .background(.white).cornerRadius(20)

            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(
                .orange
            ).toolbar {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gearshape.fill")
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Cooking Timer")
        }
    }

    private func startTimer() {
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

    private func stopTimer() {
        isTimerRunning = false
        if totalSeconds > 0 {
            soundVM.playSound(selectedSound: "stop")
        }
    }

}

#Preview("Standard Preview") {
    ContentView()
}
