/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBTag)
public class DBTag: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var name: String
    @NSManaged public var id: Int16
    
    
    /* Relacionamentos */
    
    @NSManaged public var gardens: NSSet
    @NSManaged public var foods: NSSet
    
    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBTag> {
        return NSFetchRequest<DBTag>(entityName: "DBTag")
    }
    
    
    
    /* MARK: - Relacionamentos */
    
    /* MARK: Garden */
    
    @objc(addGardensObject:)
    @NSManaged public func addToGardens(_ value: DBGarden)

    @objc(removeGardensObject:)
    @NSManaged public func removeFromGardens(_ value: DBGarden)

    @objc(addGardens:)
    @NSManaged public func addToGardens(_ values: NSSet)

    @objc(removeGardens:)
    @NSManaged public func removeFromGardens(_ values: NSSet)
    
    
    
    /* MARK: Food */
    
    @objc(addFoodsObject:)
    @NSManaged public func addToFoods(_ value: DBFood)

    @objc(removeFoodsObject:)
    @NSManaged public func removeFromFoods(_ value: DBFood)

    @objc(addFoods:)
    @NSManaged public func addToFoods(_ values: NSSet)

    @objc(removeFoods:)
    @NSManaged public func removeFromFoods(_ values: NSSet)
}
