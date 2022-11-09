/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */



import Foundation

/// Criando a extensão e um enum para validação posterior
extension UserDefaults {
    private enum UserDefaultsKeys: String {
        case isOnboarding
    }
    
/// Verifica se o usuário já entrou ou não no aplicativo
    var isOnboarding: Bool {
        get {
            bool(forKey: UserDefaultsKeys.isOnboarding.rawValue)
        } set {
            setValue(newValue, forKey: UserDefaultsKeys.isOnboarding.rawValue)
        }
    }
}
