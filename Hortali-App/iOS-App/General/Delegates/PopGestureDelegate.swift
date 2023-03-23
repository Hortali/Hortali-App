/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.NSObject
import class UIKit.UIGestureRecognizer
import protocol UIKit.UIGestureRecognizerDelegate


/// Delegate que lida com o gesto de pop de uma navigation
class PopGestureDelegate: NSObject, UIGestureRecognizerDelegate {
    
    /* MARK: - Atributos */
    
    /// Protocolo de comunicação com navigation controller
    private weak var navControllerProtocol: CustomNavigationProtocol?
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura o protocolo de comunicação com a navigation
    /// - Parameter navProtocol: protocolo
    public func setNavProtocol(for navProtocol: CustomNavigationProtocol) {
        self.navControllerProtocol = navProtocol
    }
    
    
    
    /* MARK: - Delegate */
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navProtocol = self.navControllerProtocol else { return false }
        return navProtocol.getControllersCount() > 1
    }
}
