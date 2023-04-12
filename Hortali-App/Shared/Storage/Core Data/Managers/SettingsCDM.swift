/* Gui Reis    -    gui.sreis25@gmail.com */


/// Lida com os dados de ajustes salvos no core data
internal class SettingsCDM {
    
    /* MARK: - Atributos */
    
    private var allData: [DBSettings]? {
        let fetch = DBSettings.fetchRequest()
        fetch.fetchLimit = 1

        return try? self.cdProperties?.mainContext.fetch(fetch)
    }
    
    
    public var cache: DBSettings? = nil
    
    public weak var cdProperties: CoreDataProperties?


    
    /* MARK: - Métodos (Públicos) */
    
    public func getSettingsData() -> (data: DBSettings?, error: ErrorCDHandler?) {
        if let cache { return (data: cache, error: nil) }
        
        guard let allData else { return (data: nil, error: .fetchError) }
        
        if !allData.isEmpty {
            self.cache = allData.first
            return (data: self.cache, error: nil)
        }
        
        guard let initialData = self.createInitialData()
        else { return (data: nil, error: .protocolNotSetted) }
        
        let save = self.saveChangesAndUpdateCache(on: initialData)
        return (data: initialData, error: save)
    }
    
    
    @discardableResult
    public func updateVersion(_ version: String) -> ErrorCDHandler? {
        guard let settings = self.allData?.first else { return .fetchError }
        
        settings.version = version
        return self.saveChangesAndUpdateCache(on: settings)
    }
    
    
    @discardableResult
    public func updateLastUpdate(_ lastUpdate: String) -> ErrorCDHandler? {
        guard let settings = self.allData?.first else { return .fetchError }
        
        settings.lastUpdate = lastUpdate
        return self.saveChangesAndUpdateCache(on: settings)
    }
    
    
    @discardableResult
    public func updateOnBoardingViewed(isFirstTime: Bool) -> ErrorCDHandler? {
        guard let settings = self.allData?.first else { return .fetchError }
        
        settings.isFirstTime = isFirstTime
        return self.saveChangesAndUpdateCache(on: settings)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func createInitialData() -> DBSettings? {
        guard let cdProperties else { return nil }
        
        let newData = DBSettings(context: cdProperties.mainContext)
        newData.isFirstTime = true
        newData.lastUpdate = ""
        newData.version = ""
        
        return newData
    }
    
    
    
    private func saveChangesAndUpdateCache(on data: DBSettings) -> ErrorCDHandler? {
        let save = try? self.cdProperties?.saveContext()
        guard save == nil else { return save }
        
        self.cache = data
        return nil
    }
}
