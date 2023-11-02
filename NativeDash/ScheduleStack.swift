//
//  ScheduleStack.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/29/23.
//

import SwiftUI

struct ScheduleStack: View {
    var schedules: [ScheduleData]
    var body: some View {
            VStack {
                ForEach(schedules.indices, id: \.self) { index in
                    SingleCard(schedule: schedules[index])
                        .padding(.horizontal, 0)
                    Spacer().frame(height: 15)
                }
            }
    }
}

#Preview {
    var schedules: [ScheduleData] = [
        ScheduleData(
            dayTitle: "Regular Schedule",
            bellTimes: [
                .init(periodTitle: "Assembly", start: "8:30", end: "8:45"),
                .init(periodTitle: "Period 1", start: "8:49", end: "9:32"),
                .init(periodTitle: "Period 2", start: "9:35", end: "10:17"),
                .init(periodTitle: "Period 3", start: "10:21", end: "11:03"),
            ]
        )
    ]
    return ScheduleStack(schedules: schedules)
}
