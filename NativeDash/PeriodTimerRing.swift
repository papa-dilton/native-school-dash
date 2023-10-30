//
//  PeriodTimerRing.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/29/23.
//

import SwiftUI

struct PeriodTimerRing: View {
    @Binding var progress: CGFloat
    @Binding var timeLeftInPeriod: String

    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("EmptyAccentColor"), style: StrokeStyle(lineWidth: 20))
            Circle()
                .rotation(Angle(degrees:(-(360*progress)-90)))
                .trim(from: 0, to: progress)
                .stroke(
                    Color("AccentColor"),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
            )
            Text(timeLeftInPeriod)
                .font(.largeTitle)
                .fontWeight(.semibold)
        }.frame(idealWidth: 300, idealHeight: 300, alignment: .center)
    }
}

#Preview {
    @State var progress: CGFloat = 0.8
    @State var timeLeftInPeriod: String = "9:39"
    return PeriodTimerRing(progress: $progress, timeLeftInPeriod: $timeLeftInPeriod)
}
