/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UITextField {
    
    /// Define o texto e a cor (do texto) do place holder (texto de background)
    /// - Parameters:
    ///   - text: texto do place holder
    ///   - color: cor do texto do place holder
    ///
    /// A cor é do tipo optional, caso queira deixar a cor padrão não precisa passar esse parâmetro
    internal func setupPlaceHolder(text: String, color: UIColor? = nil) {
        if let color = color {
            self.attributedPlaceholder = NSAttributedString (
                string: text,
                attributes: [NSAttributedString.Key.foregroundColor: color]
            )
        } else {
            self.placeholder = text
        }
    }
    
    
    /// Define uma única cor para os ícones
    /// - Parameter color: caso de uso da cor que vai ser usada nos ícones da search
    internal func setupIconsColor(with colorApp: AppColors) {
        let color = UIColor(colorApp)
        
        self.leftView?.tintColor = color
        self.rightView?.tintColor = color
        self.tintColor = color
        
        // Mudando a cor do botão
        if let clearButton = self.value(forKey: "_clearButton") as? UIButton {
            let imageButton = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(imageButton, for: .normal)
            clearButton.tintColor = color
        }
    }
}
