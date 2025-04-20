//
//  ColorContrast.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 20/4/25.
//

import SwiftUI

extension Color {
    var isDark: Bool {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue
        return luminance < 0.5
    }

    var contrastingTextColor: Color {
        isDark ? .white : .black
    }
}
