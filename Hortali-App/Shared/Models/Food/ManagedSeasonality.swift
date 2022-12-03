/* Macro - Grupo 05 */


/// Modelo de dados da sazonalidade dos alimentos
struct ManagedSeasonality: Codable {
    let allYear : Bool
    let period : [Int]
    let description: String
}
