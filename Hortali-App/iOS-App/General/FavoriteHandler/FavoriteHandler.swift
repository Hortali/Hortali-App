/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import struct UIKit.Selector


/// Os tipos que estão de acordo com esse protocolo lidam com itens que podem ser favoritados
protocol FavoriteHandler {
    
    /// Estado que define se está ou não favoritado
    var isFavorite: Bool { get set }
    
    /// Botão de favoritar
    var favoriteButton: CustomButton { get set }
    
    /// Configura o botão de favorito
    func setFavoriteIcon()
}


extension FavoriteHandler {
    
    var favoriteInfos: FavoriteInfo {
        return FavoriteInfo(isFavorite: self.isFavorite)
    }
    
    var favoriteIcon: AppIcons {
        return self.isFavorite ? .favoriteSelected : .favoriteNotSelected
    }
    
    
    mutating func favoriteHandler(for fav: Bool? = nil) -> Bool {
        self.updateFavoriteStatus(for: fav)
        self.updateFavoriteUI()
        self.setFavoriteIcon()
        return self.isFavorite
    }
    
    
    mutating func updateFavoriteStatus(for fav: Bool? = nil) {
        if let fav {
            self.isFavorite = fav
        } else {
            self.isFavorite.toggle()
        }
    }
    
    
    func updateFavoriteUI() {
        let infos = self.favoriteInfos
        self.favoriteButton.backgroundColor = infos.backColor
        self.favoriteButton.tintColor = infos.iconColor
    }
    
    
    func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
}
