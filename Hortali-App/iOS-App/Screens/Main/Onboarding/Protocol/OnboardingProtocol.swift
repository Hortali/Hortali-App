/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Protocolo voltado para a controller da tela de ver informações de uma horta
protocol OnboardingProtocol: NSObject {
    
    /// Atualiza o page control
    /// - Parameter index: página que vai ser atualizada
    func updateCurrentPage(to index: Int)
    
}
