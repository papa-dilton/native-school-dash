//
//  ContentView.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI



struct ContentView: View {
    @Binding var progress: CGFloat
    var schedules: [ScheduleData]
    // Get the number of seconds left in the period
    @Binding var timeLeftInPeriod: Duration
    @Binding var displayPeriod: Period
    @Binding var periodRingShouldDisplay: Bool
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                    Spacer().frame(height: 50)
                if periodRingShouldDisplay {
                    PeriodTimerRing(progress: $progress, timeLeftInPeriod: $timeLeftInPeriod)
                    Spacer().frame(height: 50)
                    Text(displayPeriod.periodTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer().frame(height: 50)
                }
                    ScheduleStack(schedules: schedules)
                    .padding(.horizontal, 40)
            }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var timeLeftInPeriod = Duration.seconds(700)
    static var progress: CGFloat = 0.6
    static var displayPeriod = Period(periodTitle: "Preview Period", start: "2:32", end: "3:21")
    static var schedules: [ScheduleData] = [
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
    static var previews: some View {
        ContentView(progress: .constant(progress), schedules: schedules, timeLeftInPeriod: .constant(timeLeftInPeriod), displayPeriod: .constant(displayPeriod), periodRingShouldDisplay: .constant(true)
        )
    }
}
