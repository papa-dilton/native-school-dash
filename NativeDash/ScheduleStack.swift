//
//  ScheduleStack.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/29/23.
//

import SwiftUI

struct ScheduleStack: View {
    var schedules: [Dictionary<String, String>]
    var body: some View {
            VStack {
                ForEach(schedules.indices, id: \.self) { index in
                    SingleCard(schedule: schedules[index])
                        .padding(.horizontal, 0)
                }
            }
    }
}

#Preview {
    var schedules: [Dictionary<String, String>] = [
        [
            "Period 1": "8:30 - 8:59",
            "Period 2": "9:00 - 9:25",
            "Period 3": "9:30 - 9:55",
        ],
        [
            "Period 1": "10:30 - 10:55",
            "Period 2": "11:00 - 11:25",
            "Period 3": "11:30 - 11:55",
        ]
    ]
    return ScheduleStack(schedules: schedules)
}
