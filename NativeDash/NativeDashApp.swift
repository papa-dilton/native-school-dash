//
//  NativeDashApp.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI

@main
struct NativeDashApp: App {
    @State var timeLeftInPeriod = Duration.seconds(0)
    @State var progress: CGFloat = 0.6
    var progressStep: CGFloat = 0
    var schedules: [ScheduleData] = [
        ScheduleData(
            dayTitle: "Regular Schedule",
            bellTimes: [
                .init(periodTitle: "Assembly", start: "8:30", end: "8:45"),
                .init(periodTitle: "Period 1", start: "8:49", end: "9:32"),
                .init(periodTitle: "Period 2", start: "9:35", end: "10:17"),
                .init(periodTitle: "Period 3", start: "10:21", end: "11:03"),
                .init(periodTitle: "Period 4", start: "11:07", end: "11:49"),
                .init(periodTitle: "Period 5", start: "11:53", end: "12:35"),
                .init(periodTitle: "Period 6", start: "12:39", end: "13:21"),
                .init(periodTitle: "Period 7", start: "13:25", end: "14:07"),
                .init(periodTitle: "Period 8", start: "14:11", end: "14:53"),
                .init(periodTitle: "Period 9", start: "14:57", end: "15:39"),
                .init(periodTitle: "Period 10", start: "15:43", end: "16:25")
            ]
        ),
        ScheduleData(
            dayTitle: "Late Start Schedule",
            bellTimes: [
                .init(periodTitle: "Assembly", start: "8:55", end: "9:05"),
                .init(periodTitle: "Period 1", start: "9:09", end: "9:49"),
                .init(periodTitle: "Period 2", start: "9:53", end: "10:33"),
                .init(periodTitle: "Period 3", start: "10:37", end: "11:17"),
                .init(periodTitle: "Period 4", start: "11:21", end: "12:01"),
                .init(periodTitle: "Period 5", start: "12:05", end: "12:45"),
                .init(periodTitle: "Period 6", start: "12:49", end: "13:29"),
                .init(periodTitle: "Period 7", start: "13:33", end: "14:13"),
                .init(periodTitle: "Period 8", start: "14:17", end: "14:57"),
                .init(periodTitle: "Period 9", start: "15:01", end: "15:41"),
                .init(periodTitle: "Period 10", start: "15:45", end: "16:25")
            ]
        ),
        ScheduleData(
            dayTitle: "Special Assembly Schedule",
            bellTimes: [
                .init(periodTitle: "Assembly", start: "8:30", end: "9:05"),
                .init(periodTitle: "Period 1", start: "9:09", end: "9:49"),
                .init(periodTitle: "Period 2", start: "9:53", end: "10:33"),
                .init(periodTitle: "Period 3", start: "10:37", end: "11:17"),
                .init(periodTitle: "Period 4", start: "11:21", end: "12:01"),
                .init(periodTitle: "Period 5", start: "12:05", end: "12:45"),
                .init(periodTitle: "Period 6", start: "12:49", end: "13:29"),
                .init(periodTitle: "Period 7", start: "13:33", end: "14:13"),
                .init(periodTitle: "Period 8", start: "14:17", end: "14:57"),
                .init(periodTitle: "Period 9", start: "15:01", end: "15:41"),
                .init(periodTitle: "Period 10", start: "15:45", end: "16:25")
            ]
        ),
        ScheduleData(
            dayTitle: "Common Day",
            bellTimes: [
                .init(periodTitle: "Assembly", start: "8:30", end: "8:37"),
                .init(periodTitle: "Period 1", start: "8:41", end: "9:20"),
                .init(periodTitle: "Period 2", start: "9:24", end: "10:03"),
                .init(periodTitle: "Period 3", start: "10:07", end: "10:46"),
                .init(periodTitle: "Common", start: "10:50", end: "11:17"),
                .init(periodTitle: "Period 4", start: "11:21", end: "12:01"),
                .init(periodTitle: "Period 5", start: "12:05", end: "12:45"),
                .init(periodTitle: "Period 6", start: "12:49", end: "13:29"),
                .init(periodTitle: "Period 7", start: "13:33", end: "14:13"),
                .init(periodTitle: "Period 8", start: "14:17", end: "14:57"),
                .init(periodTitle: "Period 9", start: "15:01", end: "15:41"),
                .init(periodTitle: "Period 10", start: "15:45", end: "16:25")
            ]
        )
    ]
    
    // Start a timer that fires an event every second to change the period time
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some Scene {
        WindowGroup {
            ContentView(progress: $progress, schedules: schedules, timeLeftInPeriod: $timeLeftInPeriod)
            
            // Recieve the timer event and re-render affected elements
            .onReceive(timer, perform: { time in
                // If seconds remaining is more than 0, subtract one second
                if timeLeftInPeriod.components.seconds > 0 {
                    timeLeftInPeriod -= .seconds(1)
                    
                    // Change Progress value to reflect percentage of period elapsed
                    let currentPeriod = getNextPeriod(schedule: schedules[1])
                    let secondsToEnd = getSecondsToPeriodStartEnd(period: currentPeriod, isEnd: true)
                    let secondsToStart = getSecondsToPeriodStartEnd(period: currentPeriod, isEnd: false)
                    progress = CGFloat(secondsToStart) / CGFloat(secondsToEnd + secondsToStart)
                }
                else {
                    timeLeftInPeriod = Duration.seconds(getSecondsToPeriodStartEnd(period: getNextPeriod(schedule: schedules[1]), isEnd: true))
                }
            })
        }
    }
    
    func applicationWillEnterForeground() {
        timeLeftInPeriod -= .seconds(1)
        
        // Change Progress value to reflect percentage of period elapsed
        let currentPeriod = getNextPeriod(schedule: schedules[1])
        let secondsToEnd = getSecondsToPeriodStartEnd(period: currentPeriod, isEnd: true)
        let secondsToStart = getSecondsToPeriodStartEnd(period: currentPeriod, isEnd: false)
        progress = CGFloat(secondsToStart) / CGFloat(secondsToEnd + secondsToStart)
    }

    func getNextPeriod(schedule: ScheduleData) -> Period {
        var periodToReturn: Period?
        let date = Date()
        let formatter = DateFormatter()
        // We need to be able to make a date object setting the end of the period as the time, so we need to get the current date and re-input it in the date constructor
        formatter.dateFormat = "yyyy/MM/dd ZZZZ"
        let yearMonthDay = formatter.string(from: date)
        formatter.dateFormat = "yyyy/MM/dd ZZZZ HH:mm:ss"
        
        for (index, period) in schedule.bellTimes.enumerated() {
            // If period start is in future (Currently in a passing period)
            if formatter.date(from: "\(yearMonthDay) \(period.start):00")!.timeIntervalSinceNow > 0 {
                periodToReturn = Period(periodTitle: "\(period.periodTitle) → \(schedule.bellTimes[index-1].periodTitle)", start: schedule.bellTimes[index-1].end, end: period.start)
                break
            } // If period end is in future (Currently in a period)
            else if formatter.date(from: "\(yearMonthDay) \(period.end):00")!.timeIntervalSinceNow > 0 {
                periodToReturn = period
                break
            }
        }
        return periodToReturn ?? Period(periodTitle: "Period not found", start: "00:00", end: "00:00")
    }
    
    // Get the number of seconds to the start or end of current period. Time must be between given period start or end
    // If isEnd = true, will return time to end, else will return time to start
    func getSecondsToPeriodStartEnd(period: Period, isEnd: Bool) -> Int {
        let nextPeriodEndTime = (isEnd ? period.end : period.start) + ":00"
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd ZZZZ"
        let yearMonthDay = formatter.string(from: date)
        formatter.dateFormat = "yyyy/MM/dd ZZZZ HH:mm:ss"
        let endOfPeriod = formatter.date(from: "\(yearMonthDay) \(nextPeriodEndTime)")
        let diff = abs(endOfPeriod!.timeIntervalSinceNow)
        return Int(diff)
    }
    
}


