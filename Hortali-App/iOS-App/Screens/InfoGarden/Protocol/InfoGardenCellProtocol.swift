/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocol são views que fazem parte
/// da collection das informaçòes de uma horta
protocol InfoGardenCellProtocol: NSObject {
    
    /// Configura a view a partir dos dados recebidos
    /// - Parameter data: dados recebidos
    func setupView(for data: ManagedGarden)
}
