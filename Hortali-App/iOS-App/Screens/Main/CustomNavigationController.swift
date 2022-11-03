/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UINavigationController


/// Navigation controller costumizada que lida com o gesto de pop para as telas que não usa a navigation bar
class CustomNavigationController: UINavigationController, CustomNavigationProtocol {
    
    /* MARK: - Atributos */
    
    /// Delegate que lida com gesto de pop
    private var popGestureDelegate: PopGestureDelegate?
    
    /// Esconde a navigation bar
    override var isNavigationBarHidden: Bool {
        didSet {
            self.gestureHandler()
        }
    }
    
    
    
    /* MARK: - Protocol */
    
    internal func getControllersCount() -> Int {
        return self.viewControllers.count
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Lida com o gesto de pop
    private func gestureHandler() {
        if self.isNavigationBarHidden {
            if self.popGestureDelegate == nil {
                self.popGestureDelegate = PopGestureDelegate()
                self.popGestureDelegate?.setNavProtocol(for: self)
                
                self.interactivePopGestureRecognizer?.delegate = self.popGestureDelegate
            }
        } else {
            self.popGestureDelegate = nil
        }
    }
}
