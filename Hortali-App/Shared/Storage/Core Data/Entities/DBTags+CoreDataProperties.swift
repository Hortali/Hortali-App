//
//  DBTags+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBTags {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBTags> {
        return NSFetchRequest<DBTags>(entityName: "DBTags")
    }

    @NSManaged public var dataID: String?
    @NSManaged public var name: String?
    @NSManaged public var gardens: NSSet?

}

// MARK: Generated accessors for gardens
extension DBTags {

    @objc(addGardensObject:)
    @NSManaged public func addToGardens(_ value: DBGarden)

    @objc(removeGardensObject:)
    @NSManaged public func removeFromGardens(_ value: DBGarden)

    @objc(addGardens:)
    @NSManaged public func addToGardens(_ values: NSSet)

    @objc(removeGardens:)
    @NSManaged public func removeFromGardens(_ values: NSSet)

}

extension DBTags : Identifiable {

}
