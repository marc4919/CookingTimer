//
//  ContentView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var number1 = 0
    @State private var isTimerRunning = false
    
    var body: some View {
    #if DEBUG
        let _ = Self._printChanges()
    #endif

        VStack(spacing: 50) {
            HStack {
                /*Picker("Hello, world!", selection: .constant(0)) {
                    ForEach(0..<60) { index in
                        Text("\(index)").tag(index)
                    }
                }.pickerStyle(.wheel)
                Picker("Hello, world!", selection: .constant(0)) {
                    ForEach(0..<60) { index in
                        Text("\(index)").tag(index)
                    }
                }.pickerStyle(.wheel)*/
                Picker("timer", selection: $number1) {
                    ForEach(0..<60) { index in
                        Text("\(index)").tag(index).font(.title)
                    }
                }.pickerStyle(.wheel).frame(width: 200, height: 140).disabled(isTimerRunning)
            }
            
            Button {
                isTimerRunning ? stopTimer() : startTimer()
            } label: {
                Label(isTimerRunning ? "Stop timer" : "Start timer", systemImage: isTimerRunning ? "xmark.circle" : "timer")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding()
                    .background(isTimerRunning ? .red : .blue, in: Capsule())
            }.disabled(number1 == 0)
                    
            
        }
        .padding()
        
    }
    
    private func startTimer() {
        Task {
            if number1 > 0 {
                isTimerRunning = true
            }
            while number1 > 0 && isTimerRunning {
                number1 -= 1
                if number1 == 0 {
                    isTimerRunning = false
                }
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }
    
    private func stopTimer() {
        if number1 > 0 && isTimerRunning {
            isTimerRunning = false
        }
        
    }
}

#Preview {
    ContentView()
}
