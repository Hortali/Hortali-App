/* Macro - Grupo 05 */


/// informaçòes para guardar o contato
struct ContactInfo {
    
    /// Tipo do ícone
    var icon: ContactIcon
    
    /// Contato da conta
    var contact: String
    
    /// Descriçào do contato
    var description: String
    
    
    init(icon: ContactIcon, contact: String) {
        self.icon = icon
        self.contact = contact
        self.description = icon.description
    }
}
