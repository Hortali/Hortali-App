/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoGardenInfosDelegate: NSObject, UICollectionViewDelegate {
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:  // Pop Up: Navegação
            break
        case 1:  // Tela: horário de funcionamento
            break
        case 2:  // Pop Up: contato
            break
        case 3:  // Página web
            break
        default: break
        }
    }
}
