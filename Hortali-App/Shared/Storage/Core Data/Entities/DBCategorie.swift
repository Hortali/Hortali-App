/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBCategorie)
public class DBCategorie: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var name: String
    

    /* Relacionamentos */
    
    @NSManaged public var foods: NSSet

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBCategorie> {
        return NSFetchRequest<DBCategorie>(entityName: "DBCategorie")
    }
    
    
    
    /* MARK: - Relacionamentos */
    
    /* MARK: Foods */
    
    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: DBFood)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: DBFood)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSSet)
}
