/* Macro - Grupo 05 */


/// Possíveis casos de visualização das hortas
enum GardenVisualization {
    
    /* MARK: - Casos */
    
    case grid
    case carousel
    
    
    /* MARK: - Variáveis */
    
    /// Ícone oposto à visualização mostrada
    var iconToggle: AppIcons {
        switch self {
        case .grid: return .carousel
        case .carousel: return .grid
        }
    }
    
    /// Valor correspondente
    var rawValue: Int {
        switch self {
        case .grid: return 0
        case .carousel: return 1
        }
    }
    
    
    
    /* MARK: - Métodos */
    
    /// Pega o tipo de visualização a partir do `rawValue`
    /// - Parameter rawValue: valor puro da visualização
    /// - Returns: tipo da visualização
    public func getTypeBy(rawValue: Int) -> GardenVisualization {
        switch self.rawValue {
        case 0:
            return .grid
        case 1:
            return .carousel
        default:
            return .carousel
        }
    }
}
