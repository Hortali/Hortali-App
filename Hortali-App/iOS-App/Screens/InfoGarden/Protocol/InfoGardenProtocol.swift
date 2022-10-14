/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Protocolo voltado para a controller da tela de ver informações de uma horta
protocol InfoGardenProtocol: NSObject {
    
    /// Atualiza o page control
    /// - Parameter index: página que vai ser atualizada
    func updateCurrentPage(to index: Int)
    
    
    /// Abre a página de horários de funcionamento
    /// - Parameter index: célula clicada
    func openHourInfoPage()
    
    
    /// Mostra as possiveis navegações para ir até o local
    func showNavigationOptions()
    
    
    /// Mostra os contatos disponíves
    func showContactOptions()
    
    
    /// Abre o link para reportar um erro
    func openReportLink()
}
