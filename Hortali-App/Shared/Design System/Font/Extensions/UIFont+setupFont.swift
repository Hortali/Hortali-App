/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIFont {

    /// Configura a fonte de acordo com a famila que está sendo usada no projeto.
    /// - Parameter config: modelo de informações para configuração da fonte.
    /// - Returns: fonte configurada de acordo com o modelo passado.
    static func setupFont(with config: FontInfo) -> UIFont? {
        let family = config.fontFamily.fontName(weight: config.weight)
        
        return UIFont(name: family, size: config.fontSize)
    }
}
