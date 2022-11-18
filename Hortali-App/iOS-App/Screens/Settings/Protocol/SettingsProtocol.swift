/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acrodo com esse protocolo pertecem a tela de configuração
protocol SettingsProtocol: NSObject {
    
    /// Abre uma página de acordo com o index passado
    /// - Parameter index: index
    func openPage(for index: Int)
}
