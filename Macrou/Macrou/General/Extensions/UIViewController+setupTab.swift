/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIViewController {
    
    /// Configura o item da tab bar da controller
    /// - Parameters:
    ///   - text: título na tab bar
    ///   - icon: icone na tab bar
    internal func setupTab(text: String, icon: AppIcons) {
        self.tabBarItem.title = text
        self.tabBarItem.image = UIImage(icon)
    }
}
