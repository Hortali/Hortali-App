/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIImage


extension UIImage {
    
    /// Cria uma imagem a partir dos assets (`AppImages`)
    /// - Parameter appImage: imagem do assets
    convenience init?(appImage: AppImages) {
        self.init(systemName: appImage.description)
    }
}
