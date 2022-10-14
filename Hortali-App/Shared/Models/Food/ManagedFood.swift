/* Macro - Grupo 05 */


/// Modelo de dados dos alimentos
struct ManagedFood: Codable {
    let id: Int
    
    let name: String
    let category: String
    let benefits: String
    let minerals: String
    
    var isFavorited: Bool?
    
    let vitamins: [ManagedVitamins]
    let coverImage: ManagedImage
    let pageImage: ManagedImage
}
