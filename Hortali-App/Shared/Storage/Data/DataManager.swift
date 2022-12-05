/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import Foundation


/// Lida com os dados do aplicativo
class DataManager {
    
    /*  MARK: - Atributos */
    
    /// Singleton
    static let shared = DataManager()
    
    
    /// Memoization: salva os dados que ja foram lidos
    private var cache: [DataType:Any] = [:]
    
    /// Lida com as configurações voltadas para os alimentos
    private let foodManager = FoodDataManager()
    
    /// Lida com as configurações voltadas para as hortas
    private let gardenManager = GardenDataManager()
    
    
    
    /*  MARK: - Construtor */
    
    // Faz com que não seja permitido a instância da classe, obrigando o uso do singleton
    private init() {}
    
    
    
    /*  MARK: - Encapsulamento */
    
    /* MARK: Hortas */
    
    /// Pega os dados das hortas
    /// - Returns: dados das hortas
    public func getGardenData() -> [ManagedGarden] {
        return self.getAllGardenData() ?? []
    }
    
    
    
    /* MARK: Alimentos */
    
    /// Pega os dados dos alimentos
    /// - Parameter category: define qual categoria de alimentos vai ser retornada. Padrão: todos os alimentos
    /// - Returns: todos os alimentos de acordo com o filtro
    public func getFoodData(for category: String? = nil) -> [ManagedFood] {
        if let category {
            var data = self.foodManager.getFoodsBy(category: category)
            
            if data.isEmpty {
                let allData = self.getAllFoodData() ?? []
                self.foodManager.analyze(data: allData)
                data = self.foodManager.getFoodsBy(category: category)
            }
            return data
        }
        
        return self.getAllFoodData() ?? []
    }
    

    /// Pega todas as categorias
    /// - Returns: lista com todas as categorias diferentes
    public func getAllCategories() -> [String] {
        var categories = self.foodManager.getAllCategories
        
        if categories.isEmpty {
            self.foodManager.analyze(data: self.getFoodData())
            categories = self.foodManager.getAllCategories
        }
        
        return categories
    }
    
    
    /// Pega os dados de uma vitamina
    /// - Parameter vitaminName: nome da vitamina
    /// - Returns: dados de uma vitamina
    public func getVitamin(for vitaminName: String) -> ManagedVitamins? {
        if let vitamins = self.cache[.vitamins] as? [ManagedVitamins] {
            for item in vitamins {
                if item.name == vitaminName {
                    return item
                }
            }
        }
        return nil
    }
    
    
    /// Pega todas as tags disponíveis
    /// - Returns: lista com as tags
    public func getAllTags() -> [ManagedTags]? {
        return self.cache[.tags] as? [ManagedTags]
    }
    
    
    
    /* MARK: Favoritos */
    
    /// Atualiza a lista de favoritos
    /// - Parameter config: atualização que vai ser feita
    public func updateFavoriteList(for config: FavoriteUpdate) {
        var list = UserDefaults.getFavoriteList(for: config.favoriteType)
        
        switch config.action {
        case .add:
            list.append(config.id)
        case .remove:
            for index in 0..<list.count {
                if list[index] == config.id {
                    list.remove(at: index)
                    break
                }
                
            }
        }
        
        UserDefaults.updateFavoriteList(in: config.favoriteType, with: list)
    }
    
    
    /// Pega os itens que estão favoritados
    /// - Parameter dataType: tipo do itens
    /// - Returns: lista com os itens favoritados
    ///
    /// Essa função retorna uma lista de `[ManagedGarden]` quando o dataType for do tipo `.garden` ou uma
    /// lista de `[ManagedFood]`quando o dataType for do tipo `.food`.
    public func getFavoriteItens(for dataType: DataType) -> [Any] {
        let favoriteIds = UserDefaults.getFavoriteList(for: dataType)
        
        switch dataType {
        case .garden:
            return self.gardenManager.getGardensBy(ids: favoriteIds, with: self.getGardenData())
        case .food:
            return self.foodManager.getFoodsBy(ids: favoriteIds, with: self.getFoodData())
        default: return []
        }
    }
    
    
    /// Pega os ids dos itens favoritados
    /// - Parameter dataType: tipo dos itens
    /// - Returns: lista com os ids favortados
    public func getFavoriteIds(for dataType: DataType) -> [Int] {
        return UserDefaults.getFavoriteList(for: dataType)
    }
    
    
    
    /*  MARK: - Gerenciamento dos Dados */
    
    /// Pega os dados da horta
    /// - Returns: retorna os dados da horta
    private func getAllGardenData() -> [ManagedGarden]? {
        let type: DataType = .garden
        
        if let cacheData = self.cache[type] as? [ManagedGarden] {
            return cacheData
        }
        
        if let data = self.readData(for: type) as? [ManagedGarden] {
            self.cache[type] = data
            return data
        }
        return nil
    }
    
    
    /// Pega os dados dos alimentos
    /// - Returns: retorna os dados dos alimentos
    private func getAllFoodData() -> [ManagedFood]? {
        let type: DataType = .food
        
        if let cacheData = self.cache[type] as? [ManagedFood] {
            return cacheData
        }
        
        if let data = self.readData(for: type) as? [ManagedFood] {
            self.cache[type] = data
            return data
        }
        return nil
    }
    
    
    
    /*  MARK: - Configurações */
    
    /// Pega os dados do JSON
    /// - Parameter file: tipo do aquivo que vai ser acessado
    /// - Returns: modleos correspondentes ao tipo de dado pedido
    ///
    /// Se a leitura for bem sucedida, essa função retorna uma lista de `[ManagedGarden]` quando o
    /// dataType for do tipo `.garden` ou uma lista de `[ManagedFood]`quando o dataType for do
    /// tipo `.food`.
    private func readData(for file: DataType) -> Any? {
        if let jsonFile = Bundle.main.url(forResource: file.jsonName, withExtension: "json") {
            let data = try? Data(contentsOf: jsonFile)
            
            if let data {
                let decoder = JSONDecoder()
                switch file {
                case .garden:
                    if let jsonData = try? decoder.decode(ManagedGardenData.self, from: data) {
                        self.cache[.tags] = jsonData.tags
                        return jsonData.gardens
                    }
                case .food:
                    if let jsonData = try? decoder.decode(ManagedFoodData.self, from: data) {
                        self.cache[.vitamins] = jsonData.vitamins
                        return jsonData.foods
                    }
                default: return nil
                }
            }
        }
        return nil
    }
}
