/* Macro - Grupo 05 */

/// Textos das empty views
enum EmptyTexts {
    
    /* MARK: - Casos */
    
    /// Texto da collection de alimentos favoritados
    case food
    
    /// Texto da collection de hortas favoritadas
    case garden
    
    /// Texto da collection de busca de hortas
    case search
    
    /// Texto da tela de favoritos vazia
    case favorite
    
    
    
    /* MARK: - Atributos */
    
    /// Textos que correspondem às empty views
    var text: String {
        switch self {
        case .food:
            return "Você ainda não tem\n alimento favorito."
        case .garden:
            return "Você ainda não tem\n horta favorita."
        case .search:
            return "Não temos nenhuma\n horta com esse nome."
        case .favorite:
            return "Você ainda não tem\n nenhum favorito."
        }
    }
}
