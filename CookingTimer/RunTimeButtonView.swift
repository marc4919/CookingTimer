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
            Label {
                Text(isTimerRunning ? "Stop timer" : "Start timer")
            } icon: {
                Image(systemName: isTimerRunning ? "xmark.circle" : "timer")
            }
        }.font(.title2)
            .foregroundStyle(.white)
            .padding()
            .background(
                isTimerRunning ? .red : .blue,
                in: Capsule()
            ).scaleEffect(isTimerRunning ? 1.1 : 1.0)
            .animation(.spring(), value: isTimerRunning)

    }
}

#Preview {
    RunTimeButtonView(isTimerRunning: false) {
        print("Start tapped")
    }
}
