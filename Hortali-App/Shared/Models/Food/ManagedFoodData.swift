/* Macro - Grupo 05 */


/// Estrutura inicial da leitura dos dados dos alimentos
struct ManagedFoodData: Codable {
    /// Quantidade de dados
    let count: Int
    
    /// Dados
    let vitamins: [ManagedVitamins]
    
    /// Dados
    let foods: [ManagedFood]
}
