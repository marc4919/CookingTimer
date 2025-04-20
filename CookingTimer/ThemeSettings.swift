//
//  ThemeSettings.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 17/4/25.
//
import SwiftUI

@Observable
class ThemeSettings {
    var mainColor: Color = .orange {
        didSet { save() }
    }

    init() { load() }

    private func save() {
        let comps = UIColor(mainColor).cgColor.components ?? [1, 0.584, 0, 1]
        let str = comps.prefix(4).map { String(format: "%.6f", $0) }.joined(
            separator: ","
        )
        UserDefaults.standard.set(str, forKey: "backgroundColorComponents")
    }

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
