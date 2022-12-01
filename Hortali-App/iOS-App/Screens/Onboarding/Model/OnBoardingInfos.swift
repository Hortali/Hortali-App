/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIImage
import class UIKit.UIColor


/// Modelo de informações usados no on boarding
struct OnBoardingInfos {
    
    /// Primeiro texto que aparece
    let primaryTitleText: String
    
    /// Palavra com fonte diferente
    let secondaryTitleText: String
    
    
    /// Texto em negrito
    let primaryDescriptionText: String
    
    /// Descrição
    let secondaryDescriptionText: String
    
    
    /// Imagem
    let image: UIImage?
    
    /// Cor de fundo (da célula)
    let color: UIColor?
}
