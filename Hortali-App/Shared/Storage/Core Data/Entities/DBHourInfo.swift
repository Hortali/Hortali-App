/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBHourInfo)
public class DBHourInfo: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var status: Bool
    @NSManaged public var week: String
    @NSManaged public var startTIme: String?
    @NSManaged public var endTime: String?
    
    
    /* Relacionamentos */
    
    @NSManaged public var gardens: NSSet?

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBHourInfo> {
        return NSFetchRequest<DBHourInfo>(entityName: "DBHourInfo")
    }
    
    
    
    /* MARK: - Relacionamentos */
    
    /* MARK: Gardens */
    
    @objc(addGardensObject:)
    @NSManaged public func addToGardens(_ value: DBGarden)

    @objc(removeGardensObject:)
    @NSManaged public func removeFromGardens(_ value: DBGarden)

    @objc(addGardens:)
    @NSManaged public func addToGardens(_ values: NSSet)

    @objc(removeGardens:)
    @NSManaged public func removeFromGardens(_ values: NSSet)
}
