//
//  ThemeSettings.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 17/4/25.
//
import SwiftUI

/// A settings model that manages and persists the app's main theme color.
///
/// This observable class allows UI elements to react to changes in the selected theme color (`mainColor`).
/// The color is automatically saved to and loaded from `UserDefaults` using RGBA components.
@Observable
class ThemeSettings {
    
    /// The main color of the app theme. Changes are persisted automatically.
    var mainColor: Color = .orange {
        didSet { save() }
    }

    /// Initializes the settings and loads the saved theme color, if available.
    init() { load() }

    /// Saves the current `mainColor` to `UserDefaults` as a comma-separated string of RGBA components.
    private func save() {
        let comps = UIColor(mainColor).cgColor.components ?? [1, 0.584, 0, 1]
        let str = comps.prefix(4).map { String(format: "%.6f", $0) }.joined(
            separator: ","
        )
        UserDefaults.standard.set(str, forKey: "backgroundColorComponents")
    }

    /// Loads the `mainColor` from `UserDefaults`, if available.
    /// Expects a comma-separated string of RGB or RGBA values.
    private func load() {
        guard
            let str = UserDefaults.standard.string(
                forKey: "backgroundColorComponents"
            )
        else { return }
        let comps =
            str
            .split(separator: ",")
            .compactMap(Double.init)
        if comps.count >= 3 {
            mainColor = Color(
                .sRGB,
                red: comps[0],
                green: comps[1],
                blue: comps[2],
                opacity: comps.count >= 4 ? comps[3] : 1
            )
        }
    }
}
