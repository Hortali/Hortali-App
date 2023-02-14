/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Configurações da fonte de uma View
struct FontInfo {
    var text: String?
    let fontSize: CGFloat
    let weight: FontWeight
    var fontFamily: AppFonts
    
    
    init(text: String? = nil, fontSize: CGFloat, weight: FontWeight, fontFamily: AppFonts? = nil) {
        self.text = text
        self.fontSize = fontSize
        self.weight = weight
        self.fontFamily = fontFamily ?? .default
    }
}
