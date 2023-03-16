/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UINavigationController


// Navigation controller costumizada que lida com o gesto de pop para as telas que não usa a navigation bar
class CustomNavigationController: UINavigationController, CustomNavigationProtocol {
    
    /* MARK: - Atributos */
    
    private var popGestureDelegate: PopGestureDelegate?
    
    
    override var isNavigationBarHidden: Bool {
        didSet { self.gestureHandler() }
    }
    
    
    
    /* MARK: - Protocol */
    
    internal func getControllersCount() -> Int {
        return self.viewControllers.count
    }
    
    
    
    /* MARK: - Configurações */
    
    private func gestureHandler() {
        guard self.isNavigationBarHidden else { self.popGestureDelegate = nil; return }
        
        guard self.popGestureDelegate.isNil else { return }
        self.popGestureDelegate = PopGestureDelegate()
        self.popGestureDelegate?.setNavProtocol(for: self)
        
        self.interactivePopGestureRecognizer?.delegate = self.popGestureDelegate
    }
}
