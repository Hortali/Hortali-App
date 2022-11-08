/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo faz com que a tela de info hortas apareça
protocol ViewControllerProtocol: NSObject {
    
    func updatedSelectedCell(at row: Int )
}
