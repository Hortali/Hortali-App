/* Macro - Grupo 05 */


/// Tipo dos dados do app
enum DataType {
    
    /* MARK: - Casos */
    
    case garden
    case food
    case vitamins
    case tags
    
    
    /* MARK: - Variáveis */
    
    /// Nome do json corresponsnde ao tipo de dado
    var jsonName: String {
        switch self {
        case .garden: return "gardenData"
        case .food: return "foodData"
        case .vitamins, .tags: return ""
        }
    }
    
    
    /// Chave do user defaults corresponsnde ao tipo de dado
    var userDefaultKey: String {
        switch self {
        case .garden: return "gardenFavorites"
        case .food: return "foodFavorites"
        case .vitamins, .tags: return ""
        }
    }
}
