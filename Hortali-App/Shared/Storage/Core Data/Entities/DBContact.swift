/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBContact)
public class DBContact: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var type: String
    @NSManaged public var contact: String
    

    /* Relacionamentos */
    
    @NSManaged public var garden: DBGarden

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBContact> {
        return NSFetchRequest<DBContact>(entityName: "DBContact")
    }
}
