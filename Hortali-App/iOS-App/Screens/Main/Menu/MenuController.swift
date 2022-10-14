/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Padrão de controller para as telas iniciais
class MenuController: UIViewController {
    
    /* MARK: - Atributos */

    /// Comunicação com a controller que tem a tab bar
    internal var tabBarProtocol: TabBarProtocol?

    
    
    /* MARK: - Encapsulamento */
    
    /// Define o protocolo de comunicaão com a controller que tem a tab bar
    /// - Parameter delegate: tipo que possui o protocolo
    public func setTabProtocol(with delegate: TabBarProtocol) {
        self.tabBarProtocol = delegate
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarProtocol?.showTabBar(is: true)
    }
}
