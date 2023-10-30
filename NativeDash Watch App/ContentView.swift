//
//  ContentView.swift
//  NativeDash Watch App
//
//  Created by student on 9/13/23.
//

import SwiftUI

struct ContentView: View {
    @State var timeLeftInPeriod: String = "34:01"
    @State var progress: CGFloat = 0.8
    var body: some View {
        PeriodTimerRing(progress: $progress, timeLeftInPeriod: $timeLeftInPeriod)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
