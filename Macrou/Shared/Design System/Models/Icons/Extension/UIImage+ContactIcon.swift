/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIImage {
    
    /// Cria uma imagem a partir de um ícone de contato do projeto (`ContactIcon`)
    /// - Parameter icon: ícone
    convenience init?(_ icon: ContactIcon) {
        self.init(named: icon.iconName)
    }
}
