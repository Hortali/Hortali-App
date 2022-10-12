/* Macro - Grupo 05 */


/// Lida com o gerenciamento dos dados das hortas
class GardenDataManager {
    
    /// Pega hortas a partir de uma lista de ids
    /// - Parameters:
    ///   - ids: lista com ids
    ///   - data: lista das hortas
    /// - Returns: hortas que possuem os ids pedidos
    public func getGardensBy(ids: [Int], with data: [ManagedGarden]) -> [ManagedGarden] {
        var favorites: [ManagedGarden] = []
        var allIds = ids
        
        for item in data {
            var found = -1
            
            for ind in 0..<allIds.count {
                if item.id == allIds[ind] {
                    found = ind
                    
                    var aux = item
                    //aux.isFavorited = true
                    favorites.append(aux)
                    break
                }
            }
            
            if found != -1 {
                allIds.remove(at: found)
            }
        }
        
        return favorites
    }
}
