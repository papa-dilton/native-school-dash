//
//  NativeDashApp.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI

@main
struct NativeDashApp: App {
    @State var timeLeftInPeriod = Duration.seconds(700)
    @State var progress: CGFloat = 0.6
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
    
    
    
    var body: some Scene {
        WindowGroup {
            ContentView(progress: $progress, schedules: schedules, timeLeftInPeriod: $timeLeftInPeriod)
        }
    }

}


func getSecondsToNextPeriod(schedule: ScheduleData) -> Int {
    return 0
}
