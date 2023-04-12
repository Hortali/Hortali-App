//
//  DBContact+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBContact> {
        return NSFetchRequest<DBContact>(entityName: "DBContact")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var contact: String?
    @NSManaged public var link: String?
    @NSManaged public var gardens: NSSet?
    @NSManaged public var contactType: DBContactType?

}

// MARK: Generated accessors for gardens
extension DBContact {

    @objc(addGardensObject:)
    @NSManaged public func addToGardens(_ value: DBGarden)

    @objc(removeGardensObject:)
    @NSManaged public func removeFromGardens(_ value: DBGarden)

    @objc(addGardens:)
    @NSManaged public func addToGardens(_ values: NSSet)

    @objc(removeGardens:)
    @NSManaged public func removeFromGardens(_ values: NSSet)

}

extension DBContact : Identifiable {

}
