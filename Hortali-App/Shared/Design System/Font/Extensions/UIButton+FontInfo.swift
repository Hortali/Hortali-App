/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIButton {
    
    internal func setupFont(with config: FontInfo) {
        var newConfig = config
        newConfig.fontFamily = .graffiti
        
        self.titleLabel?.font = UIFont.setupFont(with: newConfig)
    }
}
