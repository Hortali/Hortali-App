/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// 
protocol InfoGardenProtocol: NSObject {
    
    /// Atualiza o page control
    /// - Parameter index: página que vai ser atualizada
    func updateCurrentPage(to index: Int)
}
