//
//  DBSeasonality+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBSeasonality {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBSeasonality> {
        return NSFetchRequest<DBSeasonality>(entityName: "DBSeasonality")
    }

    @NSManaged public var allYear: Bool
    @NSManaged public var info: String?
    @NSManaged public var food: DBFood?
    @NSManaged public var seasonalityPeriod: NSSet?

}

// MARK: Generated accessors for seasonalityPeriod
extension DBSeasonality {

    @objc(addSeasonalityPeriodObject:)
    @NSManaged public func addToSeasonalityPeriod(_ value: DBSeasonalityPeriod)

    @objc(removeSeasonalityPeriodObject:)
    @NSManaged public func removeFromSeasonalityPeriod(_ value: DBSeasonalityPeriod)

    @objc(addSeasonalityPeriod:)
    @NSManaged public func addToSeasonalityPeriod(_ values: NSSet)

    @objc(removeSeasonalityPeriod:)
    @NSManaged public func removeFromSeasonalityPeriod(_ values: NSSet)

}

extension DBSeasonality : Identifiable {

}
