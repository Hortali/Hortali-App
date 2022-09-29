/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Delegate da collection de informações de uma horta
class InfoGardenInfosDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com a controller da tela de hortas
    private weak var infoGardenProtocol: InfoGardenProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    /// Define qual vai ser o protocolo do delegate
    /// - Parameter protocol: protocolo de comunicação
    public func setProtocol(with delegate: InfoGardenProtocol) {
        self.infoGardenProtocol = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:  // Pop Up: Navegação
            break
        case 1:
            self.infoGardenProtocol?.openHourInfoPage(for: indexPath.row)
        case 2:  // Pop Up: contato
            break
        case 3:  // Página web
            break
        default: break
        }
    }
}
