//
//  DataStructs.swift
//  NativeDash
//
//  Created by Dalton Harrold on 11/1/23.
//

import Foundation
public struct ScheduleData {
    let dayTitle: String
    let bellTimes: [BellTimes]
    
    
    struct BellTimes {
        var periodTitle: String
        var start: String
        var end: String
    }
    
}
