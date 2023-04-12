//
//  DBImages+CoreDataProperties.swift
//  Hortali
//
//  Created by Gui Reis on 12/04/23.
//
//

import Foundation
import CoreData


extension DBImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBImages> {
        return NSFetchRequest<DBImages>(entityName: "DBImages")
    }

    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var dataID: Int16
    @NSManaged public var link: String?
    @NSManaged public var hasDownloaded: Bool
    @NSManaged public var gardenCover: DBGarden?
    @NSManaged public var gardenPage: DBGarden?
    @NSManaged public var gardenMap: DBGarden?
    @NSManaged public var contactType: DBContactType?
    @NSManaged public var foodCover: DBFood?
    @NSManaged public var foodPage: DBFood?

}

extension DBImages : Identifiable {

}
