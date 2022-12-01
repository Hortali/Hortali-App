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
    
    
    /// Pega o valor a partir das chaves do user default
    /// - Parameter key: chave
    /// - Returns: valor boleano
    internal static func getValue(for key: UDKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.key)
    }
    
    
    /// Define o valor de uma das chaves
    /// - Parameters:
    ///   - value: valor a ser definido
    ///   - key: chave que vai ser modificada
    internal static func setValue(_ value: Bool, forKey key: UDKeys) {
        UserDefaults.standard.set(value, forKey: key.key)
    }
}
