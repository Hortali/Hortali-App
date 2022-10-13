/* Macro - Grupo 05 */


/// Modelo de dados de horários de funcionamento das hortas
struct ManagedHourInfo: Codable {
    let id: Int?
    let status: Bool
    let week: String
    let startTime: String
    let endTime: String
}
