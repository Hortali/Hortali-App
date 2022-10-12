/* Macro - Grupo 05 */


/// Qual objetivo desse enum?
enum DataType {
    case garden
    case food
    
    var jsonName: String {
        switch self {
        case .garden: return "gardenData"
        case .food: return "foodData"
        }
    }
    
    
    var userDefaultKey: String {
        switch self {
        case .garden: return "gardenFavorites"
        case .food: return "foodFavorites"
        }
    }
}
