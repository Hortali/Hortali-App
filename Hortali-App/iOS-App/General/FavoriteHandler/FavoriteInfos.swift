/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIColor


/// informações sobre o tipo de favorito
struct FavoriteInfo {
    
    /// Cor do ícone
    let iconColor: UIColor?
    
    /// Cor de fundo
    let backColor: UIColor?
    
    init(isFavorite: Bool) {
        switch isFavorite {
        case true:
            self.iconColor = UIColor(.favoriteSelectedIcon) ?? nil
            self.backColor = UIColor(.favoriteSelectedBack) ?? nil
        case false:
            self.iconColor = UIColor(.favoriteNotSelectedIcon) ?? nil
            self.backColor = UIColor(.favoriteNotSelectedBack) ?? nil
        }
    }
}
