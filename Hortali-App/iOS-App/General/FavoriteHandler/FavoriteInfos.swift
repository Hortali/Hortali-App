/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.UIColor


/// Informações sobre o tipo de favorito
struct FavoriteInfo {
    
    /// Cor do ícone
    let iconColor: UIColor?
    
    /// Cor de fundo
    let backColor: UIColor?
    
    init(isFavorite: Bool) {
        switch isFavorite {
        case true:
            self.iconColor = UIColor(.favoriteSelectedIcon)
            self.backColor = UIColor(.favoriteSelectedBack)
        case false:
            self.iconColor = UIColor(.favoriteNotSelectedIcon)
            self.backColor = UIColor(.favoriteNotSelectedBack)
        }
    }
}
