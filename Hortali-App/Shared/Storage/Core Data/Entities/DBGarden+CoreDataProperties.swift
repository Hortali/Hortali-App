//
//  DBGarden+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBGarden {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBGarden> {
        return NSFetchRequest<DBGarden>(entityName: "DBGarden")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var name: String?
    @NSManaged public var biography: String?
    @NSManaged public var lastUpdate: String?
    @NSManaged public var isFavorited: Bool
    @NSManaged public var hourInfos: NSSet?
    @NSManaged public var contacts: NSSet?
    @NSManaged public var address: DBAddress?
    @NSManaged public var tags: NSSet?
    @NSManaged public var coverImage: DBImages?
    @NSManaged public var pagesImages: NSSet?
    @NSManaged public var mapImage: DBImages?

}

// MARK: Generated accessors for hourInfos
extension DBGarden {

    @objc(addHourInfosObject:)
    @NSManaged public func addToHourInfos(_ value: DBHourInfo)

    @objc(removeHourInfosObject:)
    @NSManaged public func removeFromHourInfos(_ value: DBHourInfo)

    @objc(addHourInfos:)
    @NSManaged public func addToHourInfos(_ values: NSSet)

    @objc(removeHourInfos:)
    @NSManaged public func removeFromHourInfos(_ values: NSSet)

}

// MARK: Generated accessors for contacts
extension DBGarden {

    @objc(addContactsObject:)
    @NSManaged public func addToContacts(_ value: DBContact)

    @objc(removeContactsObject:)
    @NSManaged public func removeFromContacts(_ value: DBContact)

    @objc(addContacts:)
    @NSManaged public func addToContacts(_ values: NSSet)

    @objc(removeContacts:)
    @NSManaged public func removeFromContacts(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension DBGarden {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: DBTags)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: DBTags)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for pagesImages
extension DBGarden {

    @objc(addPagesImagesObject:)
    @NSManaged public func addToPagesImages(_ value: DBImages)

    @objc(removePagesImagesObject:)
    @NSManaged public func removeFromPagesImages(_ value: DBImages)

    @objc(addPagesImages:)
    @NSManaged public func addToPagesImages(_ values: NSSet)

    @objc(removePagesImages:)
    @NSManaged public func removeFromPagesImages(_ values: NSSet)

}

extension DBGarden : Identifiable {

}
