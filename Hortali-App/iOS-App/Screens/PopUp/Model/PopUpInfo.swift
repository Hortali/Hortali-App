/* Macro - Grupo 05 */


/// Informações mostradas no pop up
struct PopUpInfo {
    
    /* MARK: - Atibutos */
    
    /// Título
    let title: String
    
    /// Descrição
    let description: String
    
    /// Fundo do pop up
    let backgroundColor: AppColors
    
    /// Cor do botão de fechar
    let buttonColor: AppColors
    
    
    
    /* MARK: - Construtor */
    
    init(title: String, description: String, backgroundColor: AppColors? = nil, buttonColor: AppColors? = nil) {
        self.title = title
        self.description = description
    
        self.backgroundColor = backgroundColor ?? .popupDefaultBack
        self.buttonColor = buttonColor ?? .popupDefaultButton
    }
}
