/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que ficam de acordo com esse protocolo possuem uma tab bar
protocol TabBarProtocol: NSObject {
    
    /// Mostra/esconde a tab bar
    /// - Parameter visibility: se vai mostrar ou não
    func showTabBar(is visibility: Bool)
}
