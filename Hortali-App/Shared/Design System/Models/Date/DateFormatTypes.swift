/* Gui Reis    -    gui.sreis25@gmail.com */


/// Tipode de formatação de data
enum DateFormatTypes {
    
    /* MARK: - Casos */
    
    /// Dia / Mês / Ano
    case dma

    
    
    /* MARK: - Variáveis */
    
    /// Formato da data
    var format: String {
        switch self {
        case .dma:
            return "dd/MM/yy"
        }
    }
}
