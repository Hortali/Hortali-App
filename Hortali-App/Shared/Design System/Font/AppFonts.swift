/* Macro - Grupo 05 */


/// Tipos de fontes usadas no app
enum AppFonts {
    
    /* MARK: - Casos */
    
    /// Fonte padrão
    case `default`
    
    /// Estilo grafite
    case graffiti
    
    
    
    /* MARK: - Variáveis */
    
    func fontName(weight: FontWeight = .regular) -> String {
        switch self {
        case .default: return "SFProRounded-\(weight.type)"
        case .graffiti: return "AmsterdamGraffiti"
        }
    }
}
