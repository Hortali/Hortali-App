/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Delegate da search bar
class SearchDelegate: NSObject, UISearchBarDelegate {
    
    /* MARK: - Atributos */
    
    /// Comunicação entre o delegate com o tipo que está de acordo com o protocolo da search
    private weak var searchProtocol: SearchProtocol?
        

    
    /* MARK: - Encapsulamento */
    
    /**
        Define qual vai ser o protocolo
        - Parameter protocol: protocolo de comunicação
    */
    public func setProtocol(with searchProtocol: SearchProtocol ) {
        self.searchProtocol = searchProtocol
    }
    
    
    
    /* MARK: - Delegate */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchProtocol?.updateCollection(textSearch: searchText.lowercased())
    }
}
