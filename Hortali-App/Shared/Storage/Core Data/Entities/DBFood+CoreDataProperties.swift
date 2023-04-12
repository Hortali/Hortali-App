//
//  DBFood+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBFood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBFood> {
        return NSFetchRequest<DBFood>(entityName: "DBFood")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var name: String?
    @NSManaged public var benefits: String?
    @NSManaged public var minerals: String?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var coverImage: DBImages?
    @NSManaged public var pageImage: DBImages?
    @NSManaged public var categorie: DBCategorie?
    @NSManaged public var seasonality: DBSeasonality?
    @NSManaged public var vitamins: NSSet?

}

// MARK: Generated accessors for vitamins
extension DBFood {

    @objc(addVitaminsObject:)
    @NSManaged public func addToVitamins(_ value: DBVitamins)

    @objc(removeVitaminsObject:)
    @NSManaged public func removeFromVitamins(_ value: DBVitamins)

    @objc(addVitamins:)
    @NSManaged public func addToVitamins(_ values: NSSet)

    @objc(removeVitamins:)
    @NSManaged public func removeFromVitamins(_ values: NSSet)

}

extension DBFood : Identifiable {

}
