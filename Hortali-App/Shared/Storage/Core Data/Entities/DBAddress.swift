/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBAddress)
public class DBAddress: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var address: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    
    
    /* Relacionamentos */
    
    @NSManaged public var garden: DBGarden

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBAddress> {
        return NSFetchRequest<DBAddress>(entityName: "DBAddress")
    }
}
