/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


extension UIFont {

    /// Configura a fonte de acordo com a famila que está sendo usada no projeto.
    /// - Parameter config: modelo de informações para configuração da fonte.
    /// - Returns: fonte configurada de acordo com o modelo passado.
    ///
    /// Existe uma fonte que está sendo usada para o projeto: `SF Pro Rounded`
    static func setupFont(with config: FontInfo) -> UIFont {
        let family = config.fontFamily.fontName(weight: config.weight)
        let customFont = UIFont(name: family, size: config.fontSize)
        
        if let customFont {
            return customFont
        }
        
        // fonte padrão do XCode (caso não exista o asset)
        return .systemFont(ofSize: config.fontSize, weight: config.weight.systemFont)
    }
}
