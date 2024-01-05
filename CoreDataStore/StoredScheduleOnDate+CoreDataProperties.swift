//
//  StoredScheduleOnDate+CoreDataProperties.swift
//  NativeDash
//
//  Created by Dalton Harrold on 1/3/24.
//
//

import Foundation
import CoreData


extension StoredScheduleOnDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredScheduleOnDate> {
        return NSFetchRequest<StoredScheduleOnDate>(entityName: "StoredScheduleOnDate")
    }

    @NSManaged public var date: Date?
    @NSManaged public var schedule: StoredDayType?

}

extension StoredScheduleOnDate : Identifiable {

}
