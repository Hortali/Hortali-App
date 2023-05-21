/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


internal class CategorieCDM {
    
    /* MARK: - Atributos */
    
    public var allData: [DBCategorie]? {
        let fetch = DBCategorie.fetchRequest()
        let data = try? self.cdProperties?.mainContext.fetch(fetch)
        return data
    }
    
        
    public weak var cdProperties: CoreDataProperties?


    
    /* MARK: - Métodos (Públicos) */
    
    /* CRUD */
    
    @discardableResult
    public func createIfNeeded(data: ManagedCategorie) -> DBCategorie? {
        if let data = self.getDataById(data.id.int16) { return data }
        
        guard let mainContext = self.cdProperties?.mainContext else { return nil }
        
        let newData = DBCategorie(context: mainContext)
        self.populate(dbData: newData, managedData: data)
        
        return newData
    }
     
    
    @discardableResult
    public func deleteData(id: Int) -> ErrorCDHandler? {
        guard let data = self.getDataById(id.int16) else { return .dataNotFound }
        
        guard let cdProperties = self.cdProperties else { return .protocolNotSetted }
        cdProperties.mainContext.delete(data)
        
        let error = try? cdProperties.saveContext()
        return error
    }
    
    
    public func getDataByName(_ name: String) -> DBCategorie? {
        let fetch = DBCategorie.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == '\(name)'", #keyPath(DBCategorie.name))
        fetch.fetchLimit = 1
    
        let data = try? self.cdProperties?.mainContext.fetch(fetch).first
        return data
    }
    
    
    public func getFoodsEntityByCategorie(_ data: DBCategorie) -> [DBFood] {
        let set = data.foods as? Set<DBFood> ?? []
        return set.map() { $0 }
    }
    
    
    
    /* MARK: - Configurações */
    
    private func getDataById(_ id: Int16) -> DBCategorie? {
        let fetch = DBCategorie.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == \(id)", #keyPath(DBFood.dataID))
        fetch.fetchLimit = 1
        
        let data = try? self.cdProperties?.mainContext.fetch(fetch).first
        return data
    }
    
    
    private func populate(dbData: DBCategorie, managedData: ManagedCategorie) {
        dbData.dataID = managedData.id.int16
        dbData.name = managedData.name
    }
    
    
    static func transformToModel(entity: DBCategorie) -> ManagedCategorie {
        return ManagedCategorie(
            id: entity.dataID.int,
            name: entity.name
        )
    }
}
