//
//  MovingEmojiView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 20/4/25.
//

import SwiftUI

struct MovingEmojiView: View {
    var emojiSelected: String = "🍲"
    var isTimerRunning: Bool = false

    var body: some View {
        Text(emojiSelected)
            .font(.largeTitle) // Soporta Dynamic Type
            .foregroundColor(.primary) // Buen contraste automático
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.top, 50)
            .offset(x: isTimerRunning ? -5 : 5)
            .animation(
                isTimerRunning
                    ? Animation.linear(duration: 0.60).repeatForever(autoreverses: true)
                    : .default,
                value: isTimerRunning
            )
    }
}

#Preview {
    MovingEmojiView()
}
