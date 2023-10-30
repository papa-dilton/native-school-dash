//
//  SingleCard.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/27/23.
//

import SwiftUI

struct SingleCard: View {
    @State var schedule: Dictionary<String, String>
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("AccentColor"))
            Grid(
                alignment: .leading,
                horizontalSpacing: 10.0,
                verticalSpacing: 10.0
            ) {
                ForEach(schedule.sorted(by: <), id: \.key) { key, value in
                    GridRow {
                        Text(key)
                            .multilineTextAlignment(.trailing)
                            .lineLimit(1)
                            .gridColumnAlignment(.trailing)
                            .truncationMode(/*@START_MENU_TOKEN@*/.head/*@END_MENU_TOKEN@*/)
                        Spacer().frame(width: 15, height: 1)
                        Text(value)
                            .gridColumnAlignment(.leading)
                            .lineLimit(1)
                            .truncationMode(/*@START_MENU_TOKEN@*/.head/*@END_MENU_TOKEN@*/)
                    }
                }
            }
            .padding(40)
            .foregroundStyle(.white)
            .fontWeight(.bold)
        }
        .padding([.leading, .trailing], 40)
        .fixedSize(horizontal: true, vertical: true)
        
    }
}

#Preview {
    var previewSchedule: Dictionary<String, String> = [
        "Period 1": "8:30 - 8:55",
        "Period 2": "9:00 - 9:25",
        "Period 3": "9:30 - 9:55",
    ]
    
    return SingleCard(schedule: previewSchedule)
}
