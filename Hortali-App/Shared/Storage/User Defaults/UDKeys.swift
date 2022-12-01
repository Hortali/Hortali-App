/* Macro - Grupo 05 */


/// Chaves usadas no User Default
enum UDKeys {
    
    /* MARK: - Casos */
    
    /// Estado dizendon se o on boarding já foi mostrado ou não.
    case onBoardingPresented
    
    
    
    /* MARK: - Atributos */
    
    /// Nome da chave
    var key: String {
        switch self {
        case .onBoardingPresented: return "onBoarding"
        }
    }
}
