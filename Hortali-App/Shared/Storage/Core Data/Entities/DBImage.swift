/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBImage)
public class DBImage: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var name: String
    @NSManaged public var type: String
    
    
    /* Relacionamentos */
    
    @NSManaged public var gardenCover: DBGarden
    @NSManaged public var gardenPages: DBGarden
    
    @NSManaged public var foodCover: DBFood
    @NSManaged public var foodPage: DBFood
    
    @NSManaged public var tutorial: DBTutorial
    
    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBImage> {
        return NSFetchRequest<DBImage>(entityName: "DBImage")
    }
}
