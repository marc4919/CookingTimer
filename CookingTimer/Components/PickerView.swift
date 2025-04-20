//
//  PickerView.swift
//  CookingTimer
//
//  Created by Marc Garcia Teodoro on 16/4/25.
//

import SwiftUI

struct PickerView: View {
    @Binding var pickerSelection: Int
    var isTimerRunning: Bool
    let pickerLabel: String

    var body: some View {
        Picker(pickerLabel, selection: $pickerSelection) {
            ForEach(0...59, id: \.self) { index in
                Text("\(index)", comment: "Timer value")
                    .tag(index)
                    .font(.title)
                    .foregroundStyle(.black)
            }
        }.pickerStyle(.wheel).frame(width: 160, height: 160)
            .disabled(isTimerRunning)
    }
}

#Preview {
    @Previewable @State var minutes = 60
    PickerView(
        pickerSelection: $minutes,
        isTimerRunning: false,
        pickerLabel: "minutes"
    )
}
