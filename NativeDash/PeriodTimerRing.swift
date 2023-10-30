//
//  PeriodTimerRing.swift
//  NativeDash
//
//  Created by Dalton Harrold on 10/29/23.
//

import SwiftUI


extension Color {
    public static var emptyRingColorLight: Color {
        return Color(red: 0.858, green: 0.909, blue: 0.937)
    }
    
    public static var emptyRingColorDark: Color {
        return Color(red:0.1, green: 0.11, blue: 0.12)
    }

    public static var fillColor: Color {
        return Color(red: 0.309, green: 0.556, blue: 0.698)
    }
}


struct PeriodTimerRing: View {
    @Binding var progress: CGFloat
    @Binding var timeLeftInPeriod: String

    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    colorScheme == .light ?
                    Color.emptyRingColorLight
                    :
                        Color.emptyRingColorDark,
                    lineWidth: 20
                )
            Circle()
                .rotation(Angle(degrees:(-(360*progress)-90)))
                .trim(from: 0, to: progress)
                .stroke(
                    Color.fillColor,
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
