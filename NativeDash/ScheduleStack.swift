//
//  ScheduleStack.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/29/23.
//

import SwiftUI

struct ScheduleStack: View {
    @Binding var schedules: [Dictionary<String, String>]
    @State private var fillColor: Color = Color.fillColor
    var body: some View {
        ScrollView {
            ForEach(schedules.indices, id: \.self) { index in
                SingleCard(schedule: $schedules[index], fillColor: $fillColor)
            }
        }
    }
}
