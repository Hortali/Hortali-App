/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UILabel {
    
    internal func setupFont(with config: FontInfo) {
        self.font = UIFont.setupFont(with: config)
    }
}
