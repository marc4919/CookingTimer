//
//  SettingsView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 16/4/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(ThemeSettings.self) var themeSettings
    @AppStorage("is_sound_enabled") var isSoundEnabled = true
    @AppStorage("emoji_selected") var emojiSelected: String = "🍲"
    @State private var isShowingResetDialog = false
    let emojiOptions = ["🍲", "🥘", "🍜", "🍳"]

    var body: some View {
        @Bindable var theme = themeSettings

        Form {
            Section(header: Text("Preferences", comment: "The title of main settings section")) {
                ColorPicker("Select main color", selection: $theme.mainColor)
                Toggle(isOn: $isSoundEnabled) {
                    Text("Sounds enabled")
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Select emoji")
                        .font(.caption)

                    Picker("", selection: $emojiSelected) {
                        ForEach(emojiOptions, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }

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
                          emojiSelected = "🍲"
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
