/* Macro - Grupo 05 */


/// Estrutura inicial da leitura dos dados das hortas
struct ManagedGardenData: Codable {
    /// Quantidade de dados
    let count: Int
    
    /// Dados
    let gardens: [ManagedGarden]
}
