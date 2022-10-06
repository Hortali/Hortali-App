/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo faz com que a tela de info hortas apareça
protocol GardenProtocol: NSObject {
    
    /// Abre a tela de garden info
    /// - Parameter index: célula que foi aberta
    func openGardenInfo(for index: Int)
}
