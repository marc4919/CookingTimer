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
    @AppStorage("backgroundColorComponents") private var backgroundColorComponents: String = "1.0,0.584,0.0,1.0"
    private var colorSelection: Color {
            let comps = backgroundColorComponents
                .split(separator: ",")
                .compactMap { Double($0) }
            guard comps.count >= 3 else { return .orange }
            let (r, g, b, a) = (comps[0], comps[1], comps[2], comps.count >= 4 ? comps[3] : 1.0)
            return Color(.sRGB, red: r, green: g, blue: b, opacity: a)
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
                colorSelection
            ).toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                    }
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
