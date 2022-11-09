/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */



import Foundation

extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case isOnboarding
    }
    
/// Validação se o usuário já entrou no aplicativo
    var isOnboarding: Bool {
        get {
            bool(forKey: UserDefaultsKeys.isOnboarding.rawValue)
        } set {
            setValue(newValue, forKey: UserDefaultsKeys.isOnboarding.rawValue)
        }
    }
}
