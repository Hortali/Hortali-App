/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Delegate da collection de imagens de uma horta da tela de info garden
class InfoGardenImagesDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com a controller da tela de info garden
    private weak var infoGardenProtocol: InfoGardenProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    
    /// Define qual vai ser o protocolo do delegate
    /// - Parameter protocol: protocolo de comunicação
    public func setProtocol(with delegate: InfoGardenProtocol) {
        self.infoGardenProtocol = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Chamada quando uma célula vai ser mostrada
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.infoGardenProtocol?.updateCurrentPage(to: indexPath.row)
    }
}
