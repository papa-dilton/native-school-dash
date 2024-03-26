//
//  EndTimeWidget.swift
//  DashWidgetsExtension
//
//  Created by Dalton Harrold on 3/24/24.
//

import Foundation
import WidgetKit
import SwiftUI

struct EndTimeProvider: TimelineProvider {
    
    var currentHour: Int {
        Calendar.current.component(.hour, from: .now)
    }
    var currentMinute : Int {
        Calendar.current.component(.minute, from: .now)
    }
    var placeholderSixthPeriod: Period {
        var endMinute: Int = 0
        var endHour: Int = 0
        if currentMinute > 60-14 {
            endHour = currentHour + 1
            endMinute = (currentMinute + 14) % 60
        } else {
            endHour = currentHour
            endMinute = currentMinute + 14
        }
        return Period(name: "Period 6", start: "00:00", end: "\(endHour):\(endMinute)")
    }

    
    func placeholder(in context: Context) -> EndTimeEntry {
        return EndTimeEntry(date: .now, displayPeriod: placeholderSixthPeriod, scheduleName: "Regular Day")
    }

    func getSnapshot(in context: Context, completion: @escaping (EndTimeEntry) -> ()) {
        if context.isPreview {
            completion(placeholder(in: context))
            return
        }

        let entry = EndTimeEntry(date: .now, displayPeriod: placeholderSixthPeriod, scheduleName: "Regular Day")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [EndTimeEntry] = []
        
        let viewContext = PersistenceController.shared.container.viewContext
        let scheduleFetch = StoredScheduleOnDate.fetchRequest()
        
        // TODO: Make it so that end of day and start of day show static start time for school tomorrow.
        do {
            let storedSchedules = try viewContext.fetch(scheduleFetch)
            
            let currentDate = Date()
            if let todaySchedule = storedSchedules.first(where: {
                Calendar.current.isDate($0.date!, equalTo: currentDate, toGranularity: .day)
            })?.schedule?.asDayType() {
                for index in 0..<todaySchedule.periods.count {
                    let loopedPeriod = todaySchedule.periods[index]
                    
                    // TODO: make it so that passing periods show next period's end
                    // Add the period to entries
                    let periodStart = loopedPeriod.getStartAsDate()
                    
                    let entry = EndTimeEntry(date: periodStart, displayPeriod: loopedPeriod, scheduleName: todaySchedule.name)
                    entries.append(entry)
                }
            }
        } catch {
            fatalError("Could not fetch from Core Data for widget timeline. \(error)")
        }
        

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct EndTimeEntry: TimelineEntry {
    let date: Date
    let displayPeriod: Period
    let scheduleName: String
}

struct EndTimeWidgetEntryView : View {
    var entry: EndTimeProvider.Entry
    

    var body: some View {
        VStack{
            // Day type name
                Text(entry.scheduleName)
                    .font(.footnote)
                //                .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .id(entry.scheduleName)
                    .transition(.push(from: .top))
//                .background(.blue)
                
            
            // Timer
                Text(entry.displayPeriod.getEndAsDate(), style: .time)
                    .font(.system(size: 52, weight: .bold))
                    .fontWidth(.compressed)
                //                .frame(minHeight: 0)
                    .padding(0)
                    .dynamicTypeSize(.medium)
                    .minimumScaleFactor(0.8)
                    .id(entry.displayPeriod.getEndAsDate())
                //                .transition(.push(from: .leading))
                    .transition(.move(edge: .leading))
//                .background(.red)
            
            Spacer()
            
            // Period information
                Text("\(entry.displayPeriod.name)\n\(entry.displayPeriod.twelveHrStart)-\(entry.displayPeriod.twelveHrEnd)")
                    .lineLimit(2, reservesSpace: true)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .id(entry.displayPeriod.name)
                    .transition(.push(from: .bottom))
//                .background(.green)
    
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .background(.orange)
    }
}

struct EndTimeWidget: Widget {
    let kind: String = "EndTimeWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: EndTimeProvider()) { entry in
            if #available(iOS 17.0, *) {
                EndTimeWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                EndTimeWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Period End Time")
        .description("A widget to display at what time the current period ends, for when you wnat to use your own clock")
//        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    EndTimeWidget()
} timeline: {
    EndTimeEntry(date: Calendar.current.date(bySettingHour: 12, minute: 55, second: 00, of: .now)!, displayPeriod: Period(name: "Period 6", start: "12:39", end: "13:21"), scheduleName: "Regular Day")
    EndTimeEntry(date: Calendar.current.date(bySettingHour: 13, minute: 42, second: 00, of: .now)!, displayPeriod: Period(name: "Period 6 → Period 7", start: "13:21", end: "13:25"), scheduleName: "Regular Day")
    EndTimeEntry(date: Calendar.current.date(bySettingHour: 13, minute: 42, second: 00, of: .now)!, displayPeriod: Period(name: "Period 7", start: "13:25", end: "14:07"), scheduleName: "Regular Day")
    EndTimeEntry(date: Calendar.current.date(bySettingHour: 13, minute: 42, second: 00, of: .now)!, displayPeriod: Period(name: "Period 8", start: "13:25", end: "14:07"), scheduleName: "Common Day")
}