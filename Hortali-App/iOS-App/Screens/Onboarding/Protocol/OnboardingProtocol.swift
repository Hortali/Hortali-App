/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo faz com que a tela de onboarding atualize
protocol OnboardingProtocol: NSObject {
    
    /// Atualiza o page control
    /// - Parameter index: página que vai ser atualizada
    func updateCurrentPage(to index: Int)
}
