/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBFood)
public class DBFood: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var dataID: Int16
    @NSManaged public var name: String
    @NSManaged public var benefits: String
    @NSManaged public var minerals: String
    @NSManaged public var isFavorited: Bool
    
    
    /* Relacionamentos */
    
    @NSManaged public var tags: NSSet?
    @NSManaged public var categorie: DBCategorie?
    @NSManaged public var vitamins: NSSet?
    
    @NSManaged public var tutorials: NSSet?
    
    @NSManaged public var cover: DBImage?
    @NSManaged public var page: DBImage?

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBFood> {
        return NSFetchRequest<DBFood>(entityName: "DBFood")
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
    
    
    
    /* MARK: Vitaminas */
    
    @objc(addVitaminsObject:)
    @NSManaged public func addToVitamins(_ value: DBVitamin)

    @objc(removeVitaminsObject:)
    @NSManaged public func removeFromVitamins(_ value: DBVitamin)

    @objc(addVitamins:)
    @NSManaged public func addToVitamins(_ values: NSSet)

    @objc(removeVitamins:)
    @NSManaged public func removeFromVitamins(_ values: NSSet)
    
    
    
    /* MARK: Tutoriais */
    
    @objc(addTutorialsObject:)
    @NSManaged public func addToTutorials(_ value: DBTutorial)

    @objc(removeTutorialsObject:)
    @NSManaged public func removeFromTutorials(_ value: DBTutorial)

    @objc(addTutorials:)
    @NSManaged public func addToTutorials(_ values: NSSet)

    @objc(removeTutorials:)
    @NSManaged public func removeFromTutorials(_ values: NSSet)
}
