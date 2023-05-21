/* Macro - Grupo 05 */


/// Modelo de dados da sazonalidade dos alimentos
struct ManagedSeasonality: Codable {
    let allYear : Bool
    let period : [Int]
    let description: String
}


struct ManagedSeasonalityPeriod: Codable {
    let number: Int
    let name: String
}


struct ManagedCategorie: Codable {
    let id: Int
    let name: String
}
