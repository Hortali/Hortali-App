//
//  DBSettings+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBSettings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBSettings> {
        return NSFetchRequest<DBSettings>(entityName: "DBSettings")
    }

    @NSManaged public var version: String
    @NSManaged public var lastUpdate: String
    @NSManaged public var isFirstTime: Bool

}

extension DBSettings : Identifiable {

}
