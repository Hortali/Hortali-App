/* Macro - Grupo 05 */


/// Modelo de dados dos contatos das hortas
struct ManagedContact: Codable {
    let id: Int?
    let type: String
    let contact: String
    let link: String
    let description: String
}
