//
//  ColorContrast.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 20/4/25.
//

import SwiftUI

/// Extension on `Color` to provide utilities for determining color contrast and brightness when user changes background color.
extension Color {
    
    /// A Boolean value indicating whether the color is considered dark based on its luminance.
    ///
    /// The luminance is calculated using the standard formula:
    /// `0.299 * red + 0.587 * green + 0.114 * blue`
    ///
    /// A color is considered dark if its luminance is less than 0.5.
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

    /// Returns `.white` if the color is dark, or `.black` if the color is light.
    ///
    /// Useful for ensuring text remains readable against background colors with varying brightness.
    var contrastingTextColor: Color {
        isDark ? .white : .black
    }
}
