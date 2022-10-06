/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIView


/// Tipos de células da collection de informaçòes de uma horta
enum InfoGardenCellType {
    
    /* MARK: - Casos */
    
    /// Célula que mostra o endereço
    case map
    
    /// Célula que mostra os horários de funcionamento
    case time
    
    /// Célula que mostra os contatos disponíveis da horta
    case contact
    
    /// Célula para reportar algum problema
    case report
    
    
    
    /* MARK: - Atributos */
    
    /// View que corresponde a cada tipo de célula
    var view: UIView {
        switch self {
        case .map: return InfoGardenMap()
        case .time: return InfoGardenTime()
        case .contact: return InfoGardenContact()
        case .report: return InfoGardenReport()
        }
    }
    
    
    /// Título que corresponde ao tipo da célula
    var title: String {
        switch self {
        case .map: return "Endereço"
        case .time: return "Horário de Funcionamento"
        case .contact: return "Contatos"
        case .report: return "Reportar"
        }
    }
}
