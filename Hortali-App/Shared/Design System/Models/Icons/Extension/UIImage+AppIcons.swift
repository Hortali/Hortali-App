/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIImage {
    
    /// Cria uma imagem a aprtir de um símbolo do projeto (`AppIcons`)
    /// - Parameter icon: ícone
    convenience init?(_ icon: AppIcons) {
        self.init(systemName: icon.description)
    }
}
