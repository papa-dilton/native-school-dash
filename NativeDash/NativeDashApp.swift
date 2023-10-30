//
//  NativeDashApp.swift
//  NativeDash
//
//  Created by student on 9/13/23.
//

import SwiftUI

@main
struct NativeDashApp: App {
    var timeLeftInPeriod: String = "34:01"
    @State var schedules: [Dictionary<String, String>] = [
        [
            "Period 1": "8:30 - 8:55",
            "Period 2": "9:00 - 9:25",
            "Period 3": "9:30 - 9:55",
        ],
        [
            "Period 1": "10:30 - 10:55",
            "Period 2": "11:00 - 11:25",
            "Period 3": "11:30 - 11:55",
        ]
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView(timeLeftInPeriod: timeLeftInPeriod, schedules: $schedules)
        }
    }
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm:ss"
        let dateString = formatter.string(from: Date())
        return dateString
    }
}
