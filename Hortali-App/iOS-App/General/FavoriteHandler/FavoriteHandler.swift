/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import struct UIKit.Selector


/// Os tipos que estão de acordo com esse protocolo lidam com itens que podem ser favoritados
protocol FavoriteHandler {
    
    /// Estado que define se está ou não favoritado
    var isFavorite: Bool { get set }
    
    /// Botão de favoritar
    var favoriteButton: CustomButton { get set }
    
    
    /// Lida com a mudança de estado
    /// - Parameter fav: valor para definir estado de favorito
    /// - Returns: estado pós mudança
    func favoriteHandler(for fav: Bool?) -> Bool
}


extension FavoriteHandler {
    
    /// Informações do estado do favorito
    var favoriteInfos: FavoriteInfo {
        return FavoriteInfo(isFavorite: self.isFavorite)
    }
    
    /// Ícone do botão a partir do estado de favorito
    var favoriteIcon: AppIcons {
        return self.isFavorite ? .favoriteSelected : .favoriteNotSelected
    }
    
    
    /// Define a ação do botão de favorito
    public func setFavoriteButtonAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
}
