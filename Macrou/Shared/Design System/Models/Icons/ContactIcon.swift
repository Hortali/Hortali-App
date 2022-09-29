/* Macro - Grupo 05 */


/// Tipos de íones de para contato
enum ContactIcon: CustomStringConvertible {
    
    /// Símbolo do Insta
    case insta
    
    /// Símbolo do Whatts
    case whatts
    
    
    /// Descrição do contato
    var description: String {
        switch self {
        case .insta: return "perfil do instagram"
        case .whatts: return "mensagem"
        }
    }
    
    
    /// Nome do asset ícone
    var iconName: String {
        switch self {
        case .insta: return "Insta-Icon"
        case .whatts: return "Whatts-Icon"
        }
    }
}
