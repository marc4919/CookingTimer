//
//  CookingTimerApp.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 8/4/25.
//

import SwiftUI

@main
struct CookingTimerApp: App {
    let theme = ThemeSettings()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(theme)
        }
    }
}
