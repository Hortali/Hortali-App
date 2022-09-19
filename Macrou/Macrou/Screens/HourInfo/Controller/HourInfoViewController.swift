/* Macro - Grupo 05 */

/* Bibliotecas necessárias: */
import UIKit


/// Controller responsável POR
class HourInfoViewController: UIViewController {
    
    /* MARK: - Atributos */

    /// View principal que a classe vai controlar
    private let myView = HourInfoView()
    
    /* Delegate & Data Sources */
    private let collectionDataSource = HourInfoDataSource()

    
        
    /* MARK: - Ciclo de Vida */
    
    
    override func loadView() {
        self.view = self.myView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigation()
        self.setupDelegates()
        self.setupButtonsAction()
    }
    


    /* MARK: - Protocolo */
    
    

    /* MARK: - Ações de botões */

    
    
    /* MARK: - Configurações */
    
    
    /// Configurções da navigation
    private func setupNavigation() {
    
    }

    
    /// Definindo as ações dos botões
    private func setupButtonsAction() {
      
    }
    
    
    /// Definindo os delegates, data sources e protocolos
    private func setupDelegates() {
        self.myView.setDataSource(with: collectionDataSource)
    }
}
