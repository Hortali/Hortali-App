/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


internal class FoodCDM {
    
    /* MARK: - Atributos */
    
    public var allData: [DBFood]? {
        let fetch = DBFood.fetchRequest()
        let data = try? self.cdProperties?.mainContext.fetch(fetch)
        return data
    }
    
        
    public weak var cdProperties: CoreDataProperties?


    
    /* MARK: - Métodos (Públicos) */
    
    /* CRUD */
    
    @discardableResult
    public func createIfNeeded(data: ManagedFood) -> DBFood? {
        if let data = self.getDataById(data.id.int16) { return data }
        
        guard let mainContext = self.cdProperties?.mainContext else { return nil }
        
        let newData = DBFood(context: mainContext)
        self.populate(dbData: newData, managedData: data)
        
        return newData
    }
     
    
    @discardableResult
    public func updateData(with newData: ManagedFood) -> ErrorCDHandler? {
        guard let data = self.getDataById(newData.id.int16) else { return .dataNotFound }
        
        self.populate(dbData: data, managedData: newData)
        
        let save = try? self.cdProperties?.saveContext()
        return save
    }
    
    
    @discardableResult
    public func deleteData(id: Int) -> ErrorCDHandler? {
        guard let data = self.getDataById(id.int16) else { return .dataNotFound }
        
        guard let cdProperties = self.cdProperties else { return .protocolNotSetted }
        cdProperties.mainContext.delete(data)
        
        let error = try? cdProperties.saveContext()
        return error
    }
    
    
    /* Favoritos */
    
    public func getFavoritedDatas() -> [DBFood]? {
        let fetch = DBFood.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == true", #keyPath(DBFood.isFavorited))
        
        let data = try? self.cdProperties?.mainContext.fetch(fetch)
        return data
    }
    
    
    @discardableResult
    public func updateDataFavoriteStatus(id: Int, isFavorited: Bool? = nil) -> ErrorCDHandler? {
        guard let data = self.getDataById(id.int16) else { return .dataNotFound }
        
        if let isFavorited {
            data.isFavorited = isFavorited
        } else {
            data.isFavorited.toggle()
        }
        
        let error = try? self.cdProperties?.saveContext()
        return error
    }
    
    
        
    /* MARK: - Configurações */
    
    private func getDataById(_ id: Int16) -> DBFood? {
        let fetch = DBFood.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == \(id)", #keyPath(DBFood.dataID))
        fetch.fetchLimit = 1
        
        let data = try? self.cdProperties?.mainContext.fetch(fetch).first
        return data
    }
    
    
    private func populate(dbData: DBFood, managedData: ManagedFood) {
        dbData.dataID = managedData.id.int16
        dbData.name = managedData.name
        dbData.benefits = managedData.benefits
        dbData.minerals = managedData.minerals
        dbData.isFavorited = managedData.isFavorited ?? false
        
        // Relacionamentos
        dbData.categorie = self.getCategorieData(from: managedData)
        dbData.seasonality = self.getSeasonalityData(from: managedData)
    }
    
    
    private func getCategorieData(from data: ManagedFood) -> DBCategorie? {
        let categorieCDM = CategorieCDM()
        categorieCDM.cdProperties = self.cdProperties
        return categorieCDM.getDataByName(data.category)
    }
    
    
    private func getSeasonalityData(from data: ManagedFood) -> DBSeasonality? {
        let seasonalityCDM = SeasonalityCDM()
        seasonalityCDM.cdProperties = self.cdProperties
        return seasonalityCDM.createIfNeeded(data: data.seasonality)
    }
    
    
//    static func transformToModel(entity: DBFood) -> ManagedFood {
//        return ManagedFood(
//            id: entity.dataID,
//            name: entity.name,
//            category: entity.categorie?.name,
//            benefits: entity.benefits,
//            minerals: entity.minerals,
//            isFavorited: entity.isFavorited,
//            vitamins: [ManagedVitamins]],
//            coverImage: ,
//            pageImage: ,
//            seasonality: ManagedSeasonality
//        )
//    }
}
