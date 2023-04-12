//
//  DBContactType+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBContactType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBContactType> {
        return NSFetchRequest<DBContactType>(entityName: "DBContactType")
    }

    @NSManaged public var dataID: Int16
    @NSManaged public var name: String?
    @NSManaged public var info: String?
    @NSManaged public var contacts: NSSet?
    @NSManaged public var contactImage: DBImages?

}

// MARK: Generated accessors for contacts
extension DBContactType {

    @objc(addContactsObject:)
    @NSManaged public func addToContacts(_ value: DBContact)

    @objc(removeContactsObject:)
    @NSManaged public func removeFromContacts(_ value: DBContact)

    @objc(addContacts:)
    @NSManaged public func addToContacts(_ values: NSSet)

    @objc(removeContacts:)
    @NSManaged public func removeFromContacts(_ values: NSSet)

}

extension DBContactType : Identifiable {

}
