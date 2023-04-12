//
//  DBSeasonalityPeriod+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBSeasonalityPeriod {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBSeasonalityPeriod> {
        return NSFetchRequest<DBSeasonalityPeriod>(entityName: "DBSeasonalityPeriod")
    }

    @NSManaged public var number: Int16
    @NSManaged public var name: String?
    @NSManaged public var seasonalities: NSSet?

}

// MARK: Generated accessors for seasonalities
extension DBSeasonalityPeriod {

    @objc(addSeasonalitiesObject:)
    @NSManaged public func addToSeasonalities(_ value: DBSeasonality)

    @objc(removeSeasonalitiesObject:)
    @NSManaged public func removeFromSeasonalities(_ value: DBSeasonality)

    @objc(addSeasonalities:)
    @NSManaged public func addToSeasonalities(_ values: NSSet)

    @objc(removeSeasonalities:)
    @NSManaged public func removeFromSeasonalities(_ values: NSSet)

}

extension DBSeasonalityPeriod : Identifiable {

}
