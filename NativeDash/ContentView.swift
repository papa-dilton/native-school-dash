//
//  ContentView.swift
//  NativeDash
//
//  Created by student on 9/13/23.
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
            Text("14:23")
                .font(.largeTitle)
                .fontWeight(.semibold)
        }.frame(idealWidth: 300, idealHeight: 300, alignment: .center)
    }
}

struct ContentView: View {
    @State private var progress: CGFloat = 0.6
    var body: some View {
        ZStack {
            PeriodTimerRing(progress: $progress)
                .fixedSize()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
