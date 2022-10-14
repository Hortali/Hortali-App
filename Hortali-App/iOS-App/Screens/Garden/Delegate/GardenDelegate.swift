/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Delegate responsável pela collection das hortas
class GardenDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre com a controller 
    private weak var gardenProtocol: GardenProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    /// Define qual vai ser o protocolo do delegate
    /// - Parameter protocol: protocolo de comunicação
    public func setProtocol(with delegate: GardenProtocol) {
        self.gardenProtocol = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.gardenProtocol?.openGardenInfo(for: indexPath.row)
    }
}
