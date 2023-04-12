//
//  DBHourInfo+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBHourInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBHourInfo> {
        return NSFetchRequest<DBHourInfo>(entityName: "DBHourInfo")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var status: Bool
    @NSManaged public var week: String?
    @NSManaged public var startTime: String?
    @NSManaged public var endTime: String?
    @NSManaged public var garden: DBGarden?

}

extension DBHourInfo : Identifiable {

}
