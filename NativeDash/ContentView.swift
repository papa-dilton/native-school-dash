//
//  ContentView.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI

extension Color {
    public static var emptyRingColor: Color {
        return Color(red: 0.8588235294117647, green: 0.9098039215686274, blue: 0.9372549019607843)
    }

    public static var fillColor: Color {
        return Color(red: 0.30980392156862746, green: 0.5568627450980392, blue: 0.6980392156862745)
    }
}

struct PeriodTimerRing: View {
    @Binding var progress: CGFloat
    
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.emptyRingColor, lineWidth: 20)
            Circle()
                .rotation(Angle(degrees:(-(360*progress)-90)))
                .trim(from: 0, to: progress)
                .stroke(
                    Color.fillColor,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
            )
        }.frame(idealWidth: 300, idealHeight: 300, alignment: .center)
    }
}

struct ContentView: View {
    @State private var progress: CGFloat = 0.2
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
