/* Macro - Grupo 05 */


/// Modelo de dados das imagens usadas para as configurações
struct ManagedSetting {
    var version: String
    var lastUpdate: String
    var gardenVisualization: Int
    var isFirstTime: Bool
    
    
    init(version: String, lastUpdate: String, gardenVisualization: Int16, isFirstTime: Bool) {
        self.version = version
        self.lastUpdate = lastUpdate
        self.gardenVisualization = Int(gardenVisualization)
        self.isFirstTime = isFirstTime
    }
}
