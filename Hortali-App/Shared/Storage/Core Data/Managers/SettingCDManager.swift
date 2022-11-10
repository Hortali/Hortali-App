/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import CoreData


/// Lida com os dados de ajustes salvos no core data
internal class SettingCDManager {
    
    /* MARK: - Atributos */
    
    /* Protocolo */

    /// Protocolo do core data
    public weak var coreDataProperties: CoreDataProperties?


    
    /* MARK: - Métodos (Públicos) */
    
    /// Pega os dados de configuração
    /// - Parameter completionHandler: em caso de sucesso retorna as configurações
    public func getSettingsData(_ completionHandler: @escaping (Result<ManagedSetting, ErrorCDHandler>) -> Void) {
        guard let coreDataProperties else { return completionHandler(.failure(.protocolNotSetted)) }
            
        // Pega os dados do core data
        let fetch = DBSetting.fetchRequest()
        fetch.fetchLimit = 1

        if let dataFiltered = try? coreDataProperties.mainContext.fetch(fetch) {
            if dataFiltered.isEmpty {
                if let initialData = self.setupInitialData() {
                    completionHandler(.success(initialData))
                } else {
                    return completionHandler(.failure(.protocolNotSetted))
                }
                
                if let error = try? coreDataProperties.saveContext() {
                    return completionHandler(.failure(error))
                }
                return
            }
            
            let data = self.transformToModel(entity: dataFiltered[0])
            return completionHandler(.success(data))
        }
        return completionHandler(.failure(.fetchError))
    }
    
    
    /// Atualiza um dado de ajustes
    /// - Parameters:
    ///   - data: novo conjunto de dados
    ///   - completionHandler: gera um erro caso tenha algum problema no processo
    public func updateSettings(with data: ManagedSetting, _ completionHandler: @escaping (_ error: ErrorCDHandler?) -> Void) {
        guard let coreDataProperties else { return completionHandler(.protocolNotSetted) }
        
        let fetch = DBSetting.fetchRequest()
        fetch.fetchLimit = 1

        if let settings = try? coreDataProperties.mainContext.fetch(fetch).first {
            settings.editInstance(with: data, in: coreDataProperties)
            
            if let error = try? coreDataProperties.saveContext() {
                return completionHandler(error)
            }
            return completionHandler(nil)
        }
        return completionHandler(.fetchError)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os dados inciais das configurações
    /// - Returns: dados iniciais
    private func setupInitialData() -> ManagedSetting? {
        let today = Date()
        
        let initialData = ManagedSetting(
            version: "beta",
            lastUpdate: today.getDateFormatted(with: .dma),
            gardenVisualization: 0,
            isFirstTime: true
        )
        
        self.createNewInstance(with: initialData)
        return initialData
    }
    
    
    /// Transforma a entidade do core date para o modelo (struct)
    /// - Parameter entity: a entidade
    /// - Returns: modelo
    private func transformToModel(entity: DBSetting) -> ManagedSetting {
        return ManagedSetting(
            version: "",
            lastUpdate: "",
            gardenVisualization: 0,
            isFirstTime: false
        )
    }
    
    
    /// Adiciona um novo dado no core data
    /// - Parameter data: dado que vai ser adicionado
    private func createNewInstance(with data: ManagedSetting) {
        guard let coreDataProperties else { return }
        let newData = DBSetting(context: coreDataProperties.mainContext)
        newData.editInstance(with: data, in: coreDataProperties)
    }
}
