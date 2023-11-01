//
//  ContentView.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI



struct ContentView: View {
    @State private var progress: CGFloat = 0
    var schedules: [Dictionary<String, String>]
    // Get the number of seconds left in the period
    @State var timeLeftInPeriod = Duration.seconds(3000)
    // Start a timer that fires an event every second to change the period time
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            ScrollView(.vertical, showsIndicators: false) {
                    Spacer().frame(height: 50)
                    PeriodTimerRing(progress: $progress, timeLeftInPeriod: $timeLeftInPeriod)
                // Recieve the timer event and re-render affected elements
                .onReceive(timer, perform: { time in
                    // If seconds remaining is more than 0, subtract one second
                    if timeLeftInPeriod.components.seconds > 0 {
                        timeLeftInPeriod -= .seconds(1)
                    }
                })
                    Spacer().frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    ScheduleStack(schedules: schedules)
                    .padding(.horizontal, 40)
            }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var timeLeftInPeriod: String = "9:32"
    static var schedules: [Dictionary<String, String>] = [
        [
            "Period 1": "8:30 - 8:59",
            "Period 2": "9:00 - 9:25",
            "Period 3": "9:30 - 9:55",
        ],
        [
            "Period 1": "10:30 - 10:55",
            "Period 2": "11:00 - 11:25",
            "Period 3": "11:30 - 11:55",
        ]
    ]
    static var previews: some View {
        ContentView(schedules: schedules)
    }
}
