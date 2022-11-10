/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


@objc(DBSetting)
public class DBSetting: NSManagedObject, Identifiable {
    
    /* MARK: - Atributos */
    
    @NSManaged public var version: String
    @NSManaged public var lastUpdate: String
    @NSManaged public var gardenVisualization: Int16
    @NSManaged public var isFirstTime: Bool

    
    
    /* MARK: - Métodos */
    
    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DBSetting> {
        return NSFetchRequest<DBSetting>(entityName: "DBSetting")
    }
    
    
    /// Edita os valores da instancia
    /// - Parameter data: dados que vão ser definidos
    internal func editInstance(with data: ManagedSetting, in context: CoreDataProperties) {
        self.isFirstTime = data.isFirstTime
        self.lastUpdate = data.lastUpdate
        self.gardenVisualization = Int16(data.gardenVisualization)
        self.isFirstTime = data.isFirstTime
    }
}
