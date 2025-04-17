//
//  ContentView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var timerVM = TimerVM()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    @Environment(ThemeSettings.self) var themeSettings

    var body: some View {
        #if DEBUG
            let _ = Self._printChanges()
        #endif
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(spacing: 50) {
                    if timerVM.isTimerRunning {
                        Text("\(timerVM.minutes) m \(timerVM.seconds) s")
                            .font(.largeTitle)
                            .padding().frame(width: 400, height: 160)
                    } else {

                        HStack {
                            PickerView(
                                pickerSelection: $timerVM.minutes,
                                isTimerRunning: timerVM.isTimerRunning,
                                pickerLabel: "minutes"
                            )
                            PickerView(
                                pickerSelection: $timerVM.seconds,
                                isTimerRunning: timerVM.isTimerRunning,
                                pickerLabel: "seconds"
                            )
                        }

                    }

                    RunTimeButtonView(isTimerRunning: timerVM.isTimerRunning){
                        timerVM.isTimerRunning ? timerVM.stopTimer() : timerVM.startTimer()
                    }

                }.padding().frame(
                    maxWidth: 380,
                    maxHeight: isLandscape ? 350 : 500
                )
                .background(.white).cornerRadius(20)
                        Text("🍴")
                    .font(.system(size: 40)).padding(.top,50)

            }.backgroundColor(color: themeSettings.mainColor).toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Cooking Timer")
        }
    }

}

#Preview("Standard Preview") {
    ContentView().environment(ThemeSettings())
}


