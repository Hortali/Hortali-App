/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável pela principal de ver todas as hortas
class GardenController: UIViewController, GardenProtocol {
    
    func gardenProtocol() {
        
    }
    
    
    /* MARK: - Atributos */
    
    /* View */
    
    /// View principal que a classe vai controlar
    private let myView = GardenView()
    
    
    /* Delegate & Data Sources */
    private let gardenDataSource = GardenDataSource()
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDelegates()
        self.setupButtonsAction()
    }
    
    
    
    /* MARK: - Protocolo */
    
    
    
    /* MARK: - Ações de botões */
    
    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
        
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        
        self.myView.setDataSource(with: gardenDataSource)
        
    }
}
