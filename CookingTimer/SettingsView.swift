//
//  SettingsView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 16/4/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(ThemeSettings.self) var themeSettings
    @State private var isShowingResetDialog = false

    var body: some View {
        @Bindable var theme = themeSettings

        Form {
            Section(header: Text("Preferences")) {
                ColorPicker("Select main color", selection: $theme.mainColor)
            }
            Section(header: Text("Default")) {
                Button("Back to default preferences") {
                    isShowingResetDialog = true
                    }
                    .confirmationDialog(
                      "Are you sure you want to reset preferences?",
                      isPresented: $isShowingResetDialog,
                      titleVisibility: .visible
                    ) {
                      Button("Reset preferences", role: .destructive) {
                          theme.mainColor = .orange
                     }
                      Button("Cancel", role: .cancel) {
                          isShowingResetDialog = false
                      }
                    }
            }
        }
        .scrollContentBackground(.hidden)
        .backgroundColor(color: theme.mainColor)
    }
    
}

#Preview {
    SettingsView()
        .environment(ThemeSettings())

}
