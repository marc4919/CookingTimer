//
//  SettingsView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 16/4/25.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    @AppStorage("backgroundColorComponents") private var backgroundColorComponents: String = "1.0,0.584,0.0,1.0"
    @State private var colorSelection: Color = .orange
    @State private var isShowingResetDialog = false

    var body: some View {
        Form {
            Section(header: Text("Preferences")) {
                ColorPicker("Select main color", selection: $colorSelection)
                    .onChange(of: colorSelection) {
                        if let comps = UIColor(colorSelection).cgColor.components {
                            let rgba = comps.prefix(4).map { String(format: "%.6f", $0) }.joined(separator: ",")
                            backgroundColorComponents = rgba
                        }
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
                          backgroundColorComponents = "1.0,0.584,0.0,1.0"
                          getColor()                      }
                      Button("Cancel", role: .cancel) {
                          isShowingResetDialog = false
                      }
                    }
            }
        }
        .onAppear {
            getColor()
        }
        .scrollContentBackground(.hidden)
        .backgroundColor(color: colorSelection)
    }
    
    
    
    func getColor() {
        let comps = backgroundColorComponents
            .split(separator: ",")
            .compactMap { Double($0) }
        if comps.count >= 3 {
            let r = comps[0], g = comps[1], b = comps[2]
            let a = comps.count >= 4 ? comps[3] : 1.0
            colorSelection = Color(.sRGB, red: r, green: g, blue: b, opacity: a)
        }
    }
}

#Preview {
    SettingsView()
}
