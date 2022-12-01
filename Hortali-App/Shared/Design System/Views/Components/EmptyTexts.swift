/* Macro - Grupo 05 */

/// Textos das empty views
public enum EmptyTexts {
    
    /// Exibe o texto da empty view da collection de alimentos favoritados
    case food
    
    /// Exibe o texto da empty view da collection de hortas favoritadas
    case garden
    
    /// Exibe o texto da empty view da collection de busca de hortas
    case search
    
    /// Exibe o texto da empty view da tela de favoritos vazia
    case favorite
    
    
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
