//
//  DBAddress+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBAddress> {
        return NSFetchRequest<DBAddress>(entityName: "DBAddress")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var address: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var garden: DBGarden?

}

extension DBAddress : Identifiable {

}
