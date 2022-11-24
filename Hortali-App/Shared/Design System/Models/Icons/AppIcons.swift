/* Macro - Grupo 05 */


/// Ícones usados no projeto
enum AppIcons: CustomStringConvertible {
    
    /* MARK: - Casos */
    
    /* Botões */
    
    /// Símbolo - 􀯶
    case back
    
    /// Símbolo - 􀊴
    case favoriteNotSelected
    
    /// Símbolo - 􀊵
    case favoriteSelected
    
    /// Símbolo - 􀆈
    case showMore
    
    /// Símbolo - 􀆇
    case showLess
    
    
    // Collection
    
    /// Símbolo - 􀇷
    case grid
    
    /// Símbolo - 􀏟
    case carousel
    
    
    
    /* Tab */
    
    /// Símbolo - 􀎟
    case gardenTab
    
    /// Símbolo - 􀥳
    case foodTab
    
    /// Símbolo - 􀊵
    case favoriteTab
    
    /// Símbolo - 􀐛
    case settingsTab
    
    

    /* Configurações */
    
    /// Símbolo - 􀿨
    case help
    
    /// Símbolo - 􀎞
    case suggestion
    
    /// Símbolo - 􀍕
    case contactUs
    
    /// Símbolo - 􀈎
    case report
    
    
    
    /* MARK: - Nome dos Botões */
    
    /// Nome dos botões (SF Symbols)
    var description: String {
        switch self {
        case .back: return "chevron.backward"
        case .favoriteNotSelected: return "heart"
        case .favoriteSelected: return "heart.fill"
        case .showMore: return "chevron.down"
        case .showLess: return "chevron.up"
            
        case .grid: return "square.grid.2x2"
        case .carousel: return "rectangle.split.3x1"
            
        case .gardenTab: return "house.fill"
        case .foodTab: return "leaf.fill"
        case .favoriteTab: return "heart.fill"
        case .settingsTab: return "shippingbox.fill"
            
        case .help: return "questionmark.app"
        case .suggestion: return "house"
        case .contactUs: return "envelope"
        case .report: return "square.and.pencil"
        }
    }
}
