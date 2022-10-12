/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Qual objetivo desse protocolo?
protocol InfoGardenCellProtocol: NSObject {
    
    /// Configura a view a partir dos dados recebidos
    /// - Parameter data: dados recebidos
    func setupView(for data: ManagedGarden)
}
