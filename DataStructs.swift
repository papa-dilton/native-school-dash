//
//  DataStructs.swift
//  NativeDash
//
//  Created by Dalton Harrold on 11/1/23.
//

import Foundation
import CoreData

public struct DayType: Decodable {
    let name: String
    var periods: [Period]
    func to12HourTime() -> DayType {
        var newDayType = DayType(name: self.name, periods: [])
        for period in self.periods {
            let newStartHour = (Int(period.start.split(separator: ":")[0]) ?? 0) % 12
            let newEndHour = (Int(period.end.split(separator: ":")[0]) ?? 0) % 12
            let newStart = "\(newStartHour == 0 ? 12 : newStartHour):\(period.start.split(separator: ":")[1])"
            let newEnd = "\(newEndHour == 0 ? 12 : newEndHour):\(period.end.split(separator: ":")[1])"
            newDayType.periods.append(Period(name: period.name, start: newStart, end: newEnd))
        }
        return newDayType
    }
    func toStoredDayType(context: NSManagedObjectContext) -> StoredDayType {
        let newDayType = StoredDayType(context: context)
        newDayType.name = self.name
        newDayType.addToPeriodsFromArray(periods: self.periods, context: context)
        return newDayType
    }
}

public struct Period: Decodable {
    var name: String
    var start: String
    var end: String
}

public struct ApiResponse: Decodable {
    let dayTypeOnDate: DayType
    let name: String
    let _id: String
    let dayTypes: [DayType]
}

public class YearMonthDay {
    let year: Int
    let month: Int
    let day: Int
    func asDateComponents() -> DateComponents {
        return DateComponents(year: year, month: month, day: day)
    }

    init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    init(components: DateComponents) {
        self.year = components.year!
        self.month = components.month!
        self.day = components.day!
    }
}

public func getDayTypeFromApi(onDay: YearMonthDay? = nil) async throws -> ApiResponse? {
    let calendarDate = (onDay != nil) ? onDay!.asDateComponents() : Calendar.current.dateComponents([.day, .year, .month], from: Date())
    if let url = URL(string: "\(ProcessInfo.processInfo.environment["API_ENDPOINT"]!)/schools/\( ProcessInfo.processInfo.environment["SCHOOL_ID"]!)?includes=dayTypeOnDate&day=\(calendarDate.day!)&month=\(calendarDate.month!)&year=\(calendarDate.year!)") {
        var request = URLRequest(url: url)
        request.setValue(ProcessInfo.processInfo.environment["API_KEY"], forHTTPHeaderField: "authorization")
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            do {
                let jsonData = jsonString.data(using: .utf8)!
                let returnData = try JSONDecoder().decode(ApiResponse.self, from: jsonData)
                return returnData
            } catch let error {
                print(error)
            }
        }
    }
    return nil
}
