/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBConfiguration)
public class DBConfiguration: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var version: String
    @NSManaged public var lastUpdate: String
    @NSManaged public var gardenVisualization: Int16
    @NSManaged public var isFirstTime: Bool

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBConfiguration> {
        return NSFetchRequest<DBConfiguration>(entityName: "DBConfiguration")
    }
}
