//
//  ContentView.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI



struct ContentView: View {
    @State private var progress: CGFloat = 0.8
    @State var timeLeftInPeriod: String
    var schedules: [Dictionary<String, String>]
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                    Spacer().frame(height: 50)
                    PeriodTimerRing(progress: $progress, timeLeftInPeriod: $timeLeftInPeriod)
                        .fixedSize()
                    Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    ScheduleStack(schedules: schedules)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var timeLeftInPeriod: String = "9:32"
    static var schedules: [Dictionary<String, String>] = [
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
    static var previews: some View {
        ContentView(timeLeftInPeriod: timeLeftInPeriod, schedules: schedules)
    }
}
