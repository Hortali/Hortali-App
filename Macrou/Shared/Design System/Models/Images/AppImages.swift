/* Macro - Grupo 05 */


/// Assets do tipo imagem do projeto
enum AppImages: CustomStringConvertible {
    
    /// Capa de reportar um problema
    case report
    
    
    /// Nome da imagem
    var description: String {
        switch self {
        case .report: return "ReportIcon"
        }
    }
}
