/* Macro - Grupo 05 */


/// Configuração da ação do favoritos
struct FavoriteUpdate {
    /// Tipo de dado
    let favoriteType: DataType
    
    /// Id do dado
    let id: Int
    
    /// Açào que vai ser executada
    var action: FavoriteAction
}
