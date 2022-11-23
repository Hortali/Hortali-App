/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIFont


/// Tipos de peso de fonte dispoíveis
enum FontWeight {
    
    /* MARK: - Casos*/
    
    case regular
    case ultralight
    case thin
    case light
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    
    
    /* MARK: - Atributos */
    
    /// Tipo da fonte ()usado na familia
    var type: String {
        switch self {
        case .regular: return "Regular"
        case .ultralight: return "Ultralight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        }
    }
    
    /// Pega a fonte equivalente à fonte do sistema
    var systemFont: UIFont.Weight {
        switch self {
        case .regular: return .regular
        case .ultralight: return .light
        case .thin: return .thin
        case .light: return .light
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        }
    }
    
    
    
    /* MARK: - Métodos */
    
    /// Transforma o peso padrão do sistema para o pesoa padrão costumizado
    /// - Parameter weight: peso padrão do sistema
    /// - Returns: peso costumizado
    func getAppWeight(by weight: UIFont.Weight) -> FontWeight {
        switch weight {
        case .regular: return .regular
        case .thin: return .thin
        case .light: return .light
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default: return .regular
        }
    }
    
}
