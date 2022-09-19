/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// O que essa classe faz?
class InfoGardenImagesDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com a controller da tela
    private weak var infoGardenProtocol: InfoGardenProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    /** 
        Define qual vai ser o protocolo do delegate
        - Parameter protocol: protocolo de comunicação
    */
    public func setProtocol(with protocolController: InfoGardenProtocol) {
        self.infoGardenProtocol = protocolController
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Chamada quando uma célula vai ser mostrada
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.infoGardenProtocol?.updateCurrentPage(to: indexPath.row)
    }
}
