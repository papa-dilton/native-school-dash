//
//  DashWidgets.swift
//  DashWidgets
//
//  Created by Dalton Harrold on 1/4/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for offsetMultiplier in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .second, value: offsetMultiplier, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DashWidgetsEntryView : View {
    var entry: Provider.Entry
    @FetchRequest(sortDescriptors: [])
    private var weeklyScheduleStore: FetchedResults<StoredScheduleOnDate>
    @State var todaySchedule: DayType = DayType(name: "Fetching Day Type", periods: [])
    

    var body: some View {
        VStack {
            Text(weeklyScheduleStore.filter {
                Calendar.current.isDateInToday($0.date!)
            }[0].schedule!.name!)
            Text(getNextPeriod(date:entry.date, schedule:todaySchedule)?.end ?? "0")
        }
        .task {
            let scheduleFromWeeklyStore: [StoredScheduleOnDate] = weeklyScheduleStore.filter {
                Calendar.current.isDateInToday($0.date!)
            }
            todaySchedule = (scheduleFromWeeklyStore.count > 0) ? scheduleFromWeeklyStore[0].schedule!.asDayType() : todaySchedule
        }
    }
}

struct DashWidgets: Widget {
    let kind: String = "DashWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(macOS 14.0, iOS 17.0, *) {
                DashWidgetsEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                    .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            } else {
                DashWidgetsEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("JBS Dash")
        .description("A widget displaying time left before the end of the period")
    }
}

#Preview(as: .systemSmall) {
    DashWidgets()
} timeline: {
    SimpleEntry(date: .now)
}
