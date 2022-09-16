/* Macro - Grupo 05 */

import class UIKit.UIView

/// Qual objetivo desse enum?
enum InfoGardenCellType {
    
    /// 
    case map
    
    ///
    case time
    
    ///
    case contact
    
    ///
    case report
        
    var view: UIView {
        switch self {
        case .map: return InfoGardenMapCell()
        case .time: return InfoGardenMapCell()
        case .contact: return InfoGardenMapCell()
        case .report: return InfoGardenReportCell()
        }
    }
    
    
    var title: String {
        switch self {
        case .map: return "Endereço"
        case .time: return "Horário de Funcionamento"
        case .contact: return "Contatos"
        case .report: return "Reportar"
        }
    }
}
