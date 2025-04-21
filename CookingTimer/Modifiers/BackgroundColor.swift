//
//  Background.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 17/4/25.
//

import SwiftUI

struct BackgroundColor: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                color
            )
    }
}

extension View {
    func backgroundColor(color: Color) -> some View {
        self.modifier(BackgroundColor(color: color))
    }
}
