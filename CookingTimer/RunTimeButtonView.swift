//
//  RunTimeButtonView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 17/4/25.
//

import SwiftUI

struct RunTimeButtonView: View {
    var isTimerRunning: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(role: isTimerRunning ? .cancel : nil) {
            action()
        } label: {
            Label(
                isTimerRunning ? "Stop timer" : "Start timer",
                systemImage: isTimerRunning
                ? "xmark.circle" : "timer"
            )
        }.font(.title2)
            .foregroundStyle(.white)
            .padding()
            .background(
                isTimerRunning ? .red : .blue,
                in: Capsule()
            )
    }
}

#Preview {
    RunTimeButtonView(isTimerRunning: false) {
            print("Start tapped")
    }
}
