/* Macro - Grupo 05 */


/// Lida com o gerenciamento dos dados dos alimentos
class FoodDataManager {
    
    /*  MARK: - Atributos */
    
    /// Memoization: salva a lista de alimentos que já foram carregadas
    private var cache: [String:[ManagedFood]] = [:]
    
    /// Categorias dos alimentos
    private var categories: [String] = []
    
    /// Retorna as categorias disponiveis
    public var getAllCategories: [String] {
        return self.categories
    }
    
    
    /*  MARK: - Encapsulamento */
    
    /// Faz a leitura dos dados e ja separa as categorias
    /// - Parameter data: dados com os alimentos
    public func analyze(data: [ManagedFood]) {
        for item in data {
            if self.cache[item.category] == nil {
                self.cache[item.category] = [item]
                self.categories.append(item.category)
            } else {
                self.cache[item.category]?.append(item)
            }
        }
    }
    
    
    /// Pega os alimentos a partir de uma categoria
    /// - Parameter category: categoria do alimento
    /// - Returns: alimentos que possuem a mesma categoria pedida
    public func getFoodsBy(category: String) -> [ManagedFood] {
        return self.cache[category] ?? []
    }
    
    
    /// Pega os alimentos a partir de uma lista de ids
    /// - Parameters:
    ///   - ids: lista com ids
    ///   - data: lista dos alimentos
    /// - Returns: alimentos que possuem os ids pedidos
    public func getFoodsBy(ids: [Int], with data: [ManagedFood]) -> [ManagedFood] {
        var favorites: [ManagedFood] = []
        var allIds = ids
        
        for item in data {
            var found = -1
            
            for ind in 0..<allIds.count {
                if item.id == allIds[ind] {
                    found = ind
                    favorites.append(item)
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
