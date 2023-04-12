/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class Foundation.UserDefaults


extension UserDefaults {
    
    internal static func updateFavoriteList(in key: DataType, with value: [Int]) {
        UserDefaults.standard.set(value, forKey: key.userDefaultKey)
    }
    
    
    internal static func getFavoriteList(for key: DataType) -> [Int] {
        return UserDefaults.standard.object(forKey: key.userDefaultKey) as? [Int] ?? []
    }
}
