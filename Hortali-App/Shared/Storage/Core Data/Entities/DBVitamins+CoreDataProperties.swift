//
//  DBVitamins+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBVitamins {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBVitamins> {
        return NSFetchRequest<DBVitamins>(entityName: "DBVitamins")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var name: String?
    @NSManaged public var info: String?
    @NSManaged public var foods: NSSet?

}

// MARK: Generated accessors for foods
extension DBVitamins {

    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: DBFood)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: DBFood)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSSet)

}

extension DBVitamins : Identifiable {

}
