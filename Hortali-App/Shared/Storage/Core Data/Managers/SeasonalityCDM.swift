/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


internal class SeasonalityCDM {
    
    /* MARK: - Atributos */
    
    private var allData: [DBSeasonality]? {
        let fetch = DBSeasonality.fetchRequest()
        let data = try? self.cdProperties?.mainContext.fetch(fetch)
        return data
    }
    
        
    public weak var cdProperties: CoreDataProperties?


    
    /* MARK: - Métodos (Públicos) */
    
    @discardableResult
    public func createIfNeeded(data: ManagedSeasonality) -> DBSeasonality? {
        guard let mainContext = self.cdProperties?.mainContext else { return nil }
        
        let newData = DBSeasonality(context: mainContext)
        self.populate(dbData: newData, managedData: data)
        return newData
    }
    
    
    
    /* MARK: - Configurações */
    
    private func populate(dbData: DBSeasonality, managedData: ManagedSeasonality) {
        dbData.allYear = managedData.allYear
        dbData.info = managedData.description
        
        let seasonalityPeriodData = self.getSeasonalityPeriod(from: managedData)
        seasonalityPeriodData.forEach() { dbData.addToSeasonalityPeriod($0) }
    }
    
    
    private func getSeasonalityPeriod(from data: ManagedSeasonality) -> [DBSeasonalityPeriod] {
        let seasonPeriodCDM = SeasonalityPeriodCDM()
        seasonPeriodCDM.cdProperties = self.cdProperties
        let data = seasonPeriodCDM.getDataByArray(data.period)
        return data ?? []
    }
    
    
    static func transformToModel(entity: DBSeasonalityPeriod) -> ManagedSeasonalityPeriod {
        return ManagedSeasonalityPeriod(
            number: entity.number.int,
            name: entity.name ?? ""
        )
    }
}
