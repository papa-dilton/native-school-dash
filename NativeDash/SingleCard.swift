//
//  SingleCard.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/27/23.
//

import SwiftUI


struct SingleCard: View {
    @State var schedule: ScheduleData
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("AccentColor"))
            VStack {
                Text(schedule.dayTitle)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                Spacer().frame(height: 15)
                Grid(
                    alignment: .leading,
                    horizontalSpacing: 10.0,
                    verticalSpacing: 10.0
                ) {
                    ForEach(schedule.bellTimes, id: \.periodTitle) { period in
                        GridRow {
                            Text(period.periodTitle)
                                .multilineTextAlignment(.trailing)
                                .gridColumnAlignment(.trailing)
                            Spacer().frame(width: 15, height: 1)
                            Text("\(period.start) - \(period.end)")
                                .gridColumnAlignment(.leading)
                        }
                    }
                }
                .truncationMode(/*@START_MENU_TOKEN@*/.head/*@END_MENU_TOKEN@*/)
                .font(.body)
            }
            .padding(30)
            .fontWeight(.bold)
            .foregroundStyle(.white)
        }
        .fixedSize(horizontal: false, vertical: true)
        
        
    }
}

#Preview {
    var previewSchedule: ScheduleData =
        ScheduleData(
            dayTitle: "Regular Schedule",
            bellTimes: [
                .init(periodTitle: "Assembly", start: "8:30", end: "8:45"),
                .init(periodTitle: "Period 1", start: "8:49", end: "9:32"),
                .init(periodTitle: "Period 2", start: "9:35", end: "10:17"),
                .init(periodTitle: "Period 3", start: "10:21", end: "11:03"),
            ]
        )
    
    
    return SingleCard(schedule: previewSchedule)
}
