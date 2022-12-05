/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import class UIKit.NSObject


/// Os tipos que estão de acrodo com esse protocolo faz com que a collection seja atualiza com
/// o texto digitado na search bar
protocol SearchProtocol: NSObject {
    
    /// Atualiza a collection com o texto recebido da search
    /// - Parameter textSearch: texto da search
    func updateCollection(textSearch: String)
    
    
    /// Atualiza a collection com a tag selecionada
    /// - Parameter tag: tag selecionada
    func updateCollection(tag: String)
}
