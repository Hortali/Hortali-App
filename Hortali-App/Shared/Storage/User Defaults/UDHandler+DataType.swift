/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class Foundation.UserDefaults


extension UserDefaults {
    
    /// Atualiza a lista de favoritos
    internal static func updateFavoriteList(in key: DataType, with value: [Int]) {
        UserDefaults.standard.set(value, forKey: key.userDefaultKey)
    }
    
    
    /// Retorna a lista de favoritos
    internal static func getFavoriteList(for key: DataType) -> [Int] {
        return UserDefaults.standard.object(forKey: key.userDefaultKey) as? [Int] ?? []
    }
}
