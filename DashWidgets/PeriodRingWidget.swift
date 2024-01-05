//
//  PeriodRingWidget.swift
//  DashWidgetsExtension
//
//  Created by Dalton Harrold on 1/4/24.
//

import WidgetKit
import SwiftUI

struct WidgetBody : View {

    var body: some View {
        VStack {
            HStack {
                Text("Time:")
            }

            Text("Emoji:")

        }
    }
}

struct PeriodRingWidget: Widget {
    let kind: String = "DashWidgets"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: <#T##TimelineProvider#>, content: <#T##(TimelineEntry) -> View#>)
    }
}

#Preview(as: .systemSmall) {
    DashWidgets()
} timeline: {
    SimpleEntry(date: .now, emoji: "😀")
    SimpleEntry(date: .now, emoji: "🤩")
}
