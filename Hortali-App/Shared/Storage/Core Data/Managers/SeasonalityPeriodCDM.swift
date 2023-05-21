/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


internal class SeasonalityPeriodCDM {
    
    /* MARK: - Atributos */
    
    private var allData: [DBSeasonalityPeriod]? {
        let fetch = DBSeasonalityPeriod.fetchRequest()
        let data = try? self.cdProperties?.mainContext.fetch(fetch)
        return data
    }
    
        
    public weak var cdProperties: CoreDataProperties?


    
    /* MARK: - Métodos (Públicos) */
    
    @discardableResult
    public func createIfNeeded(data: ManagedSeasonalityPeriod) -> DBSeasonalityPeriod? {
        if let data = self.getDataById(data.number.int16) { return data }
        
        guard let mainContext = self.cdProperties?.mainContext else { return nil }
        
        let newData = DBSeasonalityPeriod(context: mainContext)
        self.populate(dbData: newData, managedData: data)
        return newData
    }
    
    
    public func getDataByArray(_ array: [Int]) -> [DBSeasonalityPeriod]? {
        let fetch = DBSeasonalityPeriod.fetchRequest()
        let predicateList = array.map { NSPredicate(format: "%K == \($0.int16)", #keyPath(DBSeasonalityPeriod.number)) }
        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicateList)
        fetch.predicate = compoundPredicate
        fetch.fetchLimit = array.count
        
        let data = try? self.cdProperties?.mainContext.fetch(fetch)
        return data
    }
    
    
    
    /* MARK: - Configurações */
    
    private func getDataById(_ id: Int16) -> DBSeasonalityPeriod? {
        let fetch = DBSeasonalityPeriod.fetchRequest()
        fetch.predicate = NSPredicate(format: "%K == \(id)", #keyPath(DBSeasonalityPeriod.number))
        fetch.fetchLimit = 1
        
        let data = try? self.cdProperties?.mainContext.fetch(fetch).first
        return data
    }
    
    
    private func populate(dbData: DBSeasonalityPeriod, managedData: ManagedSeasonalityPeriod) {
        dbData.number = managedData.number.int16
        dbData.name = managedData.name
    }
    
    
    static func transformToModel(entity: DBSeasonalityPeriod) -> ManagedSeasonalityPeriod {
        return ManagedSeasonalityPeriod(
            number: entity.number.int,
            name: entity.name ?? ""
        )
    }
}
