/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBTutorial)
public class DBTutorial: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var stepDescription: String?
    
    
    /* Relacionamentos */
    
    @NSManaged public var image: DBImage?
    @NSManaged public var foods: NSSet?

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBTutorial> {
        return NSFetchRequest<DBTutorial>(entityName: "DBTutorial")
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
