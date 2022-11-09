/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBGarden)
public class DBGarden: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var name: String
    @NSManaged public var biography: String
    @NSManaged public var lastUpdate: Date
    @NSManaged public var moreInfo: String?
    @NSManaged public var isFavorited: Bool
    
    
    /* Relacionamentos */
    
    @NSManaged public var address: DBAddress?
    @NSManaged public var hourInfos: NSSet?
    @NSManaged public var contacts: NSSet?
    @NSManaged public var tags: NSSet?
    
    @NSManaged public var pages: NSSet?
    @NSManaged public var cover: DBImage?
    
    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBGarden> {
        return NSFetchRequest<DBGarden>(entityName: "DBGarden")
    }
    
    
    
    /* MARK: - Relacionamentos */
    
    /* MARK: Tags */
    
    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: DBTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: DBTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)
    
    
    
    /* MARK: Imagens (da horta) */
    
    @objc(addPagesObject:)
    @NSManaged public func addToPages(_ value: DBImage)

    @objc(removePagesObject:)
    @NSManaged public func removeFromPages(_ value: DBImage)

    @objc(addPages:)
    @NSManaged public func addToPages(_ values: NSSet)

    @objc(removePages:)
    @NSManaged public func removeFromPages(_ values: NSSet)
    
    
    
    /* MARK: Contatos */
    
    @objc(addContactsObject:)
    @NSManaged public func addToContacts(_ value: DBContact)

    @objc(removeContactsObject:)
    @NSManaged public func removeFromContacts(_ value: DBContact)

    @objc(addContacts:)
    @NSManaged public func addToContacts(_ values: NSSet)

    @objc(removeContacts:)
    @NSManaged public func removeFromContacts(_ values: NSSet)
    
    
    
    /* MARK: Horários de Funcionamentos */
    
    @objc(addHourInfosObject:)
    @NSManaged public func addToHourInfos(_ value: DBHourInfo)

    @objc(removeHourInfosObject:)
    @NSManaged public func removeFromHourInfos(_ value: DBHourInfo)

    @objc(addHourInfos:)
    @NSManaged public func addToHourInfos(_ values: NSSet)

    @objc(removeHourInfos:)
    @NSManaged public func removeFromHourInfos(_ values: NSSet)
}
