/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit

class FoodCollectionDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    // private weak var protocol: ?
        

    
    /* MARK: - Encapsulamento */
    

        /// Define o protocolo (View Controller -> Delegate)
    internal func setProtocol(with protocolo: FoodProtocol) -> Void {
//        self.protocol = protocol
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    internal func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let protocol = self.protocol else {return}
    }
}
