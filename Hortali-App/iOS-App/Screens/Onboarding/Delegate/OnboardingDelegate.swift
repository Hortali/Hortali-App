/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Delegate da collection de onboarding
class OnboardingDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com a controller da tela de onboarding
    private weak var onboardingProtocol: OnboardingProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    /// Define qual vai ser o protocolo do delegate
    /// - Parameter protocol: protocolo de comunicação
    public func setProtocol(with delegate: OnboardingProtocol) {
        self.onboardingProtocol = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Chamada quando uma célula vai ser mostrada
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.onboardingProtocol?.updateCurrentPage(to: indexPath.row)
    }
}
